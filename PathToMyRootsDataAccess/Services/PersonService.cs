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

        public async Task<Person> AddPersonAsync(Person personFromServer)
        {
            // identity should be 0, otherwise sql insert fails
            personFromServer.Id = 0;

            bool isValid = personFromServer.FirstSpouseId == null && personFromServer.SecondSpouseId == null;

            Person? firstSpouse = null;
            Person? secondSpouse = null;

            if (personFromServer.FirstSpouseId != null)
            {
                firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.FirstSpouseId.Value);

                // invalid if first spouse already has two spouses
                isValid =
                    firstSpouse != null &&
                    (firstSpouse.FirstSpouseId == null || firstSpouse.SecondSpouseId == null);
            }

            if (isValid && personFromServer.SecondSpouseId != null)
            {
                secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.SecondSpouseId.Value);

                // invalid if second spouse already has two spouses
                isValid =
                    secondSpouse != null &&
                    (secondSpouse.FirstSpouseId == null || secondSpouse.SecondSpouseId == null);
            }

            if (!isValid)
                throw new Exception("Invalid spouse data");

            if (firstSpouse != null)
            {
                if (firstSpouse.FirstSpouseId == null)
                {
                    await _pathToMyRootsDbContext.Persons.AddAsync(personFromServer);
                    await _pathToMyRootsDbContext.SaveChangesAsync();

                    firstSpouse.FirstSpouseId = personFromServer.Id;
                    firstSpouse.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(firstSpouse);
                }
                else if (firstSpouse.SecondSpouseId == null)
                {
                    await _pathToMyRootsDbContext.Persons.AddAsync(personFromServer);
                    await _pathToMyRootsDbContext.SaveChangesAsync();

                    firstSpouse.SecondSpouseId = personFromServer.Id;
                    firstSpouse.SecondMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.SecondMarriageEndDate = personFromServer.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(firstSpouse);
                }
            }

            if (secondSpouse != null)
            {
                if (secondSpouse.FirstSpouseId == null)
                {
                    if (personFromServer.Id == 0)
                    {
                        await _pathToMyRootsDbContext.Persons.AddAsync(personFromServer);
                        await _pathToMyRootsDbContext.SaveChangesAsync();
                    }

                    secondSpouse.FirstSpouseId = personFromServer.Id;
                    secondSpouse.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(secondSpouse);
                }
                else if (secondSpouse.SecondSpouseId == null)
                {
                    if (personFromServer.Id == 0)
                    {
                        await _pathToMyRootsDbContext.Persons.AddAsync(personFromServer);
                        await _pathToMyRootsDbContext.SaveChangesAsync();
                    }

                    secondSpouse.SecondSpouseId = personFromServer.Id;
                    secondSpouse.SecondMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = personFromServer.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(secondSpouse);
                }
            }

            if (personFromServer.Id == 0)
                await _pathToMyRootsDbContext.Persons.AddAsync(personFromServer);

            await _pathToMyRootsDbContext.SaveChangesAsync();

            return personFromServer;
        }

        public async Task<List<Person>> GetPersonsAsync()
        {
            var persons = await
                _pathToMyRootsDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.AdoptiveFather)
                    .Include(p => p.AdoptiveMother)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .ToListAsync();

            return persons;
        }

        public async Task<Person?> GetPersonAsync(int id)
        {
            var person = await
                _pathToMyRootsDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.AdoptiveFather)
                    .Include(p => p.AdoptiveMother)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .Include(p => p.InverseBiologicalMother)
                    .Include(p => p.InverseBiologicalFather)
                    .Include(p => p.InverseAdoptiveMother)
                    .Include(p => p.InverseAdoptiveFather)
                    .FirstOrDefaultAsync(p => p.Id == id);

            return person;
        }

        

        public async Task<Person> EditPersonAsync(Person personFromServer)
        {
            var personFromDb = await _pathToMyRootsDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == personFromServer.Id);

            if (personFromDb == null)
                return null;

            bool isValid = personFromServer.FirstSpouseId == null && personFromServer.SecondSpouseId == null;

            Person? firstSpouse = null;
            Person? secondSpouse = null;

            if (personFromServer.FirstSpouseId.HasValue)
            {
                firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.FirstSpouseId.Value);

                // invalid if first spouse already has two spouses and none of them is the actual one
                isValid =
                    firstSpouse != null &&
                    ((firstSpouse.FirstSpouseId == null || firstSpouse.SecondSpouseId == null) ||
                    (firstSpouse.FirstSpouseId == personFromServer.Id || firstSpouse.SecondSpouseId == personFromServer.Id));
            }

            if (isValid && personFromServer.SecondSpouseId.HasValue)
            {
                secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromServer.SecondSpouseId.Value);

                // invalid if second spouse already has two spouses and none of them is the actual one
                isValid =
                    secondSpouse != null &&
                    ((secondSpouse.FirstSpouseId == null || secondSpouse.SecondSpouseId == null) ||
                    (secondSpouse.FirstSpouseId == personFromServer.Id || secondSpouse.SecondSpouseId == personFromServer.Id));
            }

            if (!isValid)
                throw new Exception("Invalid spouse data");

            // delete current from old first spouse if necessary
            if (personFromServer.FirstSpouseId != personFromDb.FirstSpouseId && personFromDb.FirstSpouseId != null)
            {
                var firstSpouseFromDb = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.FirstSpouseId.Value);
                if (firstSpouseFromDb == null)
                {
                    // should not happen
                    return null;
                }
                if (firstSpouseFromDb.FirstSpouseId == personFromDb.Id)
                {
                    firstSpouseFromDb.FirstSpouseId = null;
                    firstSpouseFromDb.FirstMarriageStartDate = null;
                    firstSpouseFromDb.FirstMarriageEndDate = null;
                }
                if (firstSpouseFromDb.SecondSpouseId == personFromDb.Id)
                {
                    firstSpouseFromDb.SecondSpouseId = null;
                    firstSpouseFromDb.SecondMarriageStartDate = null;
                    firstSpouseFromDb.SecondMarriageEndDate = null;
                }

                _pathToMyRootsDbContext.Persons.Update(firstSpouseFromDb);
            }

            // delete current from old second spouse if necessary
            if (personFromServer.SecondSpouseId != personFromDb.SecondSpouseId && personFromDb.SecondSpouseId != null)
            {
                var secondSpouseFromDb = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.SecondSpouseId.Value);
                if (secondSpouseFromDb == null)
                {
                    // should not happen
                    return null;
                }
                if (secondSpouseFromDb.FirstSpouseId == personFromDb.Id)
                {
                    secondSpouseFromDb.FirstSpouseId = null;
                    secondSpouseFromDb.FirstMarriageStartDate = null;
                    secondSpouseFromDb.FirstMarriageEndDate = null;
                }
                if (secondSpouseFromDb.SecondSpouseId == personFromDb.Id)
                {
                    secondSpouseFromDb.SecondSpouseId = null;
                    secondSpouseFromDb.SecondMarriageStartDate = null;
                    secondSpouseFromDb.SecondMarriageEndDate = null;
                }

                _pathToMyRootsDbContext.Persons.Update(secondSpouseFromDb);
            }

            // update data of first spouse
            if (firstSpouse != null)
            {
                if (firstSpouse.FirstSpouseId == personFromServer.Id)
                {
                    firstSpouse.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;
                }
                else if (firstSpouse.SecondSpouseId == personFromServer.Id)
                {
                    firstSpouse.SecondMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.SecondMarriageEndDate = personFromServer.FirstMarriageEndDate;
                }
                else if (firstSpouse.FirstSpouseId == null)
                {
                    firstSpouse.FirstSpouseId = personFromServer.Id;
                    firstSpouse.FirstMarriageStartDate = personFromServer.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = personFromServer.FirstMarriageEndDate;
                }
                else if (firstSpouse.SecondSpouseId == null)
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
                if (secondSpouse.FirstSpouseId == personFromServer.Id)
                {
                    secondSpouse.FirstMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }
                else if (secondSpouse.SecondSpouseId == personFromServer.Id)
                {
                    secondSpouse.SecondMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }
                else if (secondSpouse.FirstSpouseId == null)
                {
                    secondSpouse.FirstSpouseId = personFromServer.Id;
                    secondSpouse.FirstMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.FirstMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }
                else if (secondSpouse.SecondSpouseId == null)
                {
                    secondSpouse.SecondSpouseId = personFromServer.Id;
                    secondSpouse.SecondMarriageStartDate = personFromServer.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = personFromServer.SecondMarriageEndDate;
                }

                _pathToMyRootsDbContext.Persons.Update(secondSpouse);
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
            var person = await _pathToMyRootsDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == id);

            if (person == null)
                return false;

            _pathToMyRootsDbContext.Persons.Remove(person);
            await _pathToMyRootsDbContext.SaveChangesAsync();

            return true;
        }
    }
}
