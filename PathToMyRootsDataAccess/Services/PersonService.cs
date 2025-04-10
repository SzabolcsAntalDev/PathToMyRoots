using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;
using System;

namespace PathToMyRootsDataAccess.Services
{
    public class PersonService
    {
        private readonly PathToMyRootsDbContext _pathToMyRootsDbContext;

        public PersonService(PathToMyRootsDbContext pathToMyRootsDbContext)
        {
            _pathToMyRootsDbContext = pathToMyRootsDbContext;
        }

        public async Task<Person> AddPersonAsync(Person person)
        {
            // identity should be 0, otherwise sql insert fails
            person.Id = 0;

            Person? firstSpouse = null;
            Person? secondSpouse = null;

            if (person.FirstSpouseId != null)
            {
                firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(person.FirstSpouseId.Value);
                if (firstSpouse == null)
                    throw new Exception($"First spouse with id {person.FirstSpouseId} not found.");

                // if first spouse already has two spouses
                if (firstSpouse.FirstSpouseId != null && firstSpouse.SecondSpouseId != null)
                    throw new Exception($"First spouse with id {person.FirstSpouseId} already has two spouses.");
            }

            if (person.SecondSpouseId != null)
            {
                secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(person.SecondSpouseId.Value);
                if (secondSpouse == null)
                    throw new Exception($"Second spouse with id {person.SecondSpouseId} not found.");

                // if second spouse already has two spouses
                if (secondSpouse.FirstSpouseId != null && secondSpouse.SecondSpouseId != null)
                    throw new Exception($"Second spouse with id {person.SecondSpouseId} already has two spouses.");
            }

            await _pathToMyRootsDbContext.Persons.AddAsync(person);
            await _pathToMyRootsDbContext.SaveChangesAsync();

            if (firstSpouse != null)
            {
                // add the current person to the first available spouse spot of its first spouse
                if (firstSpouse.FirstSpouseId == null)
                {
                    firstSpouse.FirstSpouseId = person.Id;
                    firstSpouse.FirstMarriageStartDate = person.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = person.FirstMarriageEndDate;
                }
                // add the current person to the second available spouse spot of its first spouse
                else
                {
                    firstSpouse.SecondSpouseId = person.Id;
                    firstSpouse.SecondMarriageStartDate = person.FirstMarriageStartDate;
                    firstSpouse.SecondMarriageEndDate = person.FirstMarriageEndDate;
                }

                _pathToMyRootsDbContext.Persons.Update(firstSpouse);
            }

            if (secondSpouse != null)
            {
                // add the current person to the first available spouse spot of its second spouse
                if (secondSpouse.FirstSpouseId == null)
                {
                    secondSpouse.FirstSpouseId = person.Id;
                    secondSpouse.FirstMarriageStartDate = person.SecondMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = person.SecondMarriageEndDate;
                }
                // add the current person to the second available spouse spot of its second spouse
                else
                {
                    secondSpouse.SecondSpouseId = person.Id;
                    secondSpouse.SecondMarriageStartDate = person.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = person.SecondMarriageEndDate;
                }

                _pathToMyRootsDbContext.Persons.Update(secondSpouse);
            }

            await _pathToMyRootsDbContext.SaveChangesAsync();

            return person;
        }

        public async Task<Person?> GetPersonAsync(int id)
        {
            var person = await _pathToMyRootsDbContext.Persons.FirstOrDefaultAsync(p => p.Id == id);
            if (person == null)
                return null;

            var entityEntry = _pathToMyRootsDbContext.Entry(person);

            // Szabi: I think this can be optimized, or at least written with Include
            await entityEntry.Reference(p => p.BiologicalFather).LoadAsync();
            await entityEntry.Reference(p => p.BiologicalMother).LoadAsync();
            await entityEntry.Reference(p => p.AdoptiveFather).LoadAsync();
            await entityEntry.Reference(p => p.AdoptiveMother).LoadAsync();
            await entityEntry.Reference(p => p.FirstSpouse).LoadAsync();
            await entityEntry.Reference(p => p.SecondSpouse).LoadAsync();

            await entityEntry.Collection(p => p.InverseBiologicalMother).LoadAsync();
            await entityEntry.Collection(p => p.InverseBiologicalFather).LoadAsync();
            await entityEntry.Collection(p => p.InverseAdoptiveMother).LoadAsync();
            await entityEntry.Collection(p => p.InverseAdoptiveFather).LoadAsync();

            return person;
        }

        public async Task<Person> UpdatePersonAsync(Person personFromServer)
        {
            var personFromDb = await _pathToMyRootsDbContext.Persons.FirstOrDefaultAsync(p => p.Id == personFromServer.Id);

            if (personFromDb == null)
                throw new Exception($"Person with id {personFromServer.Id} not found.");

            Person? firstSpouse = null;
            Person? secondSpouse = null;

            // first spouse does not have two spouses and none being the current person
            if (personFromServer.FirstSpouseId != null)
            {
                firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.FirstSpouseId.Value);
                if (firstSpouse == null)
                    throw new Exception($"First spouse with id {personFromServer.FirstSpouseId} not found.");

                // if first spouse already has two spouses and none of them is the actual one
                if (firstSpouse.FirstSpouseId != null &&
                    firstSpouse.SecondSpouseId != null &&
                    firstSpouse.FirstSpouseId != personFromServer.Id &&
                    firstSpouse.SecondSpouseId != personFromServer.Id)
                    throw new Exception($"First spouse with id {personFromServer.FirstSpouseId} already has two spouses and none of them is the current person.");
            }

            // second spouse does not have two spouses and none being the current person
            if (personFromServer.SecondSpouseId != null)
            {
                secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.SecondSpouseId.Value);
                if (secondSpouse == null)
                    throw new Exception($"Second spouse with id {personFromServer.SecondSpouseId} not found.");

                // if second spouse already has two spouses and none of them is the actual one
                if (secondSpouse.FirstSpouseId != null &&
                    secondSpouse.SecondSpouseId != null &&
                    secondSpouse.FirstSpouseId != personFromServer.Id &&
                    secondSpouse.SecondSpouseId != personFromServer.Id)
                    throw new Exception($"Second spouse with id {personFromServer.SecondSpouseId} already has two spouses and none of them is the current person.");
            }

            Person? oldFirstSpouse = null;
            Person? oldSecondSpouse = null;

            if (personFromDb.FirstSpouseId != null)
                oldFirstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.FirstSpouseId.Value);

            if (personFromDb.SecondSpouseId != null)
                oldSecondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.SecondSpouseId.Value);

            // delete current person from old first spouse
            if (oldFirstSpouse != null)
            {
                // if current person was old spouse's first spouse
                if (oldFirstSpouse.FirstSpouseId == personFromDb.Id)
                {
                    oldFirstSpouse.FirstSpouseId = null;
                    oldFirstSpouse.FirstMarriageStartDate = null;
                    oldFirstSpouse.FirstMarriageEndDate = null;
                }
                // if current person was old spouse's second spouse
                else
                {
                    oldFirstSpouse.SecondSpouseId = null;
                    oldFirstSpouse.SecondMarriageStartDate = null;
                    oldFirstSpouse.SecondMarriageEndDate = null;
                }

                _pathToMyRootsDbContext.Persons.Update(oldFirstSpouse);
            }

            // delete current person from old second spouse
            if (oldSecondSpouse != null)
            {
                // if current person was old spouse's first spouse
                if (oldSecondSpouse.FirstSpouseId == personFromDb.Id)
                {
                    oldSecondSpouse.FirstSpouseId = null;
                    oldSecondSpouse.FirstMarriageStartDate = null;
                    oldSecondSpouse.FirstMarriageEndDate = null;
                }
                // if current person was old spouse's second spouse
                else
                {
                    oldSecondSpouse.SecondSpouseId = null;
                    oldSecondSpouse.SecondMarriageStartDate = null;
                    oldSecondSpouse.SecondMarriageEndDate = null;
                }

                _pathToMyRootsDbContext.Persons.Update(oldSecondSpouse);
            }

            // update data of first spouse
            if (firstSpouse != null)
            {
                // if first spouse spot is free
                if (firstSpouse.FirstSpouseId == null)
                {
                    firstSpouse.FirstSpouseId = personFromServer.Id;
                    firstSpouse.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;
                }
                // if second spouse spot is free
                else
                {
                    firstSpouse.SecondSpouseId = personFromServer.Id;
                    firstSpouse.SecondMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.SecondMarriageEndDate = personFromServer.FirstMarriageEndDate;
                }

                _pathToMyRootsDbContext.Persons.Update(firstSpouse);
            }

            // update data of second spouse
            if (secondSpouse != null)
            {
                // if first spouse spot is free
                if (secondSpouse.FirstSpouseId == null)
                {
                    secondSpouse.FirstSpouseId = personFromServer.Id;
                    secondSpouse.FirstMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }
                // if second spouse spot is free
                else
                {
                    secondSpouse.SecondSpouseId = personFromServer.Id;
                    secondSpouse.SecondMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }

                _pathToMyRootsDbContext.Persons.Update(secondSpouse);
            }

            // move first old spouse's second spouse into the first spouse if available
            // in order to not have first spouse noull and second spouse not null
            if (oldFirstSpouse != null)
            {
                if (oldFirstSpouse.FirstSpouseId == null && oldFirstSpouse.SecondSpouseId != null)
                {
                    oldFirstSpouse.FirstSpouseId = oldFirstSpouse.SecondSpouseId;
                    oldFirstSpouse.FirstMarriageStartDate = oldFirstSpouse.SecondMarriageStartDate;
                    oldFirstSpouse.FirstMarriageEndDate = oldFirstSpouse.SecondMarriageEndDate;

                    oldFirstSpouse.SecondSpouseId = null;
                    oldFirstSpouse.SecondMarriageStartDate = null;
                    oldFirstSpouse.SecondMarriageEndDate = null;
                }
            }

            // move second old spouse's second spouse into the first spouse if available
            // in order to not have first spouse noull and second spouse not null
            if (oldSecondSpouse != null)
            {
                if (oldSecondSpouse.FirstSpouseId == null && oldSecondSpouse.SecondSpouseId != null)
                {
                    oldSecondSpouse.FirstSpouseId = oldSecondSpouse.SecondSpouseId;
                    oldSecondSpouse.FirstMarriageStartDate = oldSecondSpouse.SecondMarriageStartDate;
                    oldSecondSpouse.FirstMarriageEndDate = oldSecondSpouse.SecondMarriageEndDate;

                    oldSecondSpouse.SecondSpouseId = null;
                    oldSecondSpouse.SecondMarriageStartDate = null;
                    oldSecondSpouse.SecondMarriageEndDate = null;
                }
            }

            personFromDb.NobleTitle = personFromServer.NobleTitle;
            personFromDb.FirstName = personFromServer.FirstName;
            personFromDb.LastName = personFromServer.LastName;
            personFromDb.MaidenName = personFromServer.MaidenName;
            personFromDb.OtherNames = personFromServer.OtherNames;
            personFromDb.IsMale = personFromServer.IsMale;
            personFromDb.BirthDate = personFromServer.BirthDate;
            personFromDb.DeathDate = personFromServer.DeathDate;
            personFromDb.BiologicalMotherId = personFromServer.BiologicalMotherId;
            personFromDb.BiologicalFatherId = personFromServer.BiologicalFatherId;
            personFromDb.AdoptiveMotherId = personFromServer.AdoptiveMotherId;
            personFromDb.AdoptiveFatherId = personFromServer.AdoptiveFatherId;
            personFromDb.FirstSpouseId = personFromServer.FirstSpouseId;
            personFromDb.SecondSpouseId = personFromServer.SecondSpouseId;
            personFromDb.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
            personFromDb.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;
            personFromDb.SecondMarriageStartDate = personFromServer.SecondMarriageStartDate;
            personFromDb.SecondMarriageEndDate = personFromServer.SecondMarriageEndDate;
            personFromDb.ImageUrl = personFromServer.ImageUrl;

            _pathToMyRootsDbContext.Persons.Update(personFromDb);
            await _pathToMyRootsDbContext.SaveChangesAsync();

            return personFromDb;
        }

        public async Task<bool> DeletePersonAsync(int id)
        {
            var person =
                await _pathToMyRootsDbContext.Persons
                    .Include(p => p.InverseBiologicalMother)
                    .Include(p => p.InverseBiologicalFather)
                    .Include(p => p.InverseAdoptiveMother)
                    .Include(p => p.InverseAdoptiveFather)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .FirstOrDefaultAsync(p => p.Id == id);

            if (person == null)
                throw new Exception($"Person with id {id} not found.");

            // remove the actual person as parent from its children
            var children =
                person.InverseBiologicalFather.Concat(
                person.InverseBiologicalMother).Concat(
                person.InverseAdoptiveFather).Concat(
                person.InverseAdoptiveMother);
            
            foreach (var child in children)
            {
                if (child.BiologicalFatherId == id)
                    child.BiologicalFatherId = null;
                if (child.BiologicalMotherId == id)
                    child.BiologicalMotherId = null;
                if (child.AdoptiveFatherId == id)
                    child.AdoptiveFatherId = null;
                if (child.AdoptiveMotherId == id)
                    child.AdoptiveMotherId = null;
            }

            // remove the actual person from its first spouse
            var firstSpouse = person.FirstSpouse;
            if (firstSpouse != null)
            {
                if (firstSpouse.FirstSpouseId == id)
                {
                    firstSpouse.FirstSpouseId = null;
                    firstSpouse.FirstMarriageStartDate = null;
                    firstSpouse.FirstMarriageEndDate = null;
                }
                else
                {
                    firstSpouse.SecondSpouseId = null;
                    firstSpouse.SecondMarriageStartDate = null;
                    firstSpouse.SecondMarriageEndDate = null;
                }

                // move first spouse's second spouse into the first spouse if available
                // in order to not have first spouse noull and second spouse not null
                if (firstSpouse.FirstSpouseId == null && firstSpouse.SecondSpouseId != null)
                {
                    firstSpouse.FirstSpouseId = firstSpouse.SecondSpouseId;
                    firstSpouse.FirstMarriageStartDate = firstSpouse.SecondMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = firstSpouse.SecondMarriageEndDate;

                    firstSpouse.SecondSpouseId = null;
                    firstSpouse.SecondMarriageStartDate = null;
                    firstSpouse.SecondMarriageEndDate = null;
                }
            }

            // remove the actual person from its second spouse
            var secondSpouse = person.SecondSpouse;
            if (secondSpouse != null)
            {
                if (secondSpouse.FirstSpouseId == id)
                {
                    secondSpouse.FirstSpouseId = null;
                    secondSpouse.FirstMarriageStartDate = null;
                    secondSpouse.FirstMarriageEndDate = null;
                }
                else
                {
                    secondSpouse.SecondSpouseId = null;
                    secondSpouse.SecondMarriageStartDate = null;
                    secondSpouse.SecondMarriageEndDate = null;
                }

                // move first spouse's second spouse into the first spouse if available
                // in order to not have first spouse noull and second spouse not null
                if (secondSpouse.FirstSpouseId == null && secondSpouse.SecondSpouseId != null)
                {
                    secondSpouse.FirstSpouseId = secondSpouse.SecondSpouseId;
                    secondSpouse.FirstMarriageStartDate = secondSpouse.SecondMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = secondSpouse.SecondMarriageEndDate;

                    secondSpouse.SecondSpouseId = null;
                    secondSpouse.SecondMarriageStartDate = null;
                    secondSpouse.SecondMarriageEndDate = null;
                }
            }

            _pathToMyRootsDbContext.Persons.Remove(person);
            await _pathToMyRootsDbContext.SaveChangesAsync();

            return true;
        }

        public async Task<List<Person>> GetPersonsAsync()
        {
            var persons =
                await _pathToMyRootsDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.AdoptiveFather)
                    .Include(p => p.AdoptiveMother)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .ToListAsync();

            return persons;
        }
    }
}
