using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;
using System;

namespace PathToMyRootsDataAccess.Services
{
    public class PersonService
    {
        private readonly PathToMyRootsDbContext _applicationDbContext;
        private readonly FamilyHelper _familyHelper;
        public PersonService(PathToMyRootsDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
            _familyHelper = new FamilyHelper(_applicationDbContext);
        }

        public async Task<List<Person>> GetPersonsAsync()
        {
            var persons = await
                _applicationDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.AdoptiveFather)
                    .Include(p => p.AdoptiveMother)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .ToListAsync();

            return persons;
        }

        public async Task<Person> GetFamilyAsync(int personId)
        {
            var family = await _familyHelper.GetFamilyAsync(personId);
            return family;
        }

        public async Task<Person?> GetPersonAsync(int id)
        {
            return await
                _applicationDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.AdoptiveFather)
                    .Include(p => p.AdoptiveMother)
                    .Include(p => p.FirstSpouse)
                    .Include(p => p.SecondSpouse)
                    .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Person> AddPersonAsync(Person person)
        {
            // Szabi: identity should be 0 cause sql insert fails otherwise
            person.Id = 0;

            await _applicationDbContext.Persons.AddAsync(person);
            await _applicationDbContext.SaveChangesAsync();

            if (person.FirstSpouseId.HasValue)
            {
                var firstSpouse = await _applicationDbContext.Persons.FindAsync(person.FirstSpouseId.Value);
                if (firstSpouse != null)
                {
                    firstSpouse.FirstSpouseId = person.Id;
                    firstSpouse.FirstMarriageStartDate = person.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = person.FirstMarriageEndDate;

                    _applicationDbContext.Persons.Update(firstSpouse);
                    await _applicationDbContext.SaveChangesAsync();
                }
            }

            if (person.SecondSpouseId.HasValue)
            {
                var secondSpouse = await _applicationDbContext.Persons.FindAsync(person.SecondSpouseId.Value);
                if (secondSpouse != null)
                {
                    secondSpouse.SecondSpouseId = person.Id;
                    secondSpouse.SecondMarriageStartDate = person.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = person.SecondMarriageEndDate;

                    _applicationDbContext.Persons.Update(secondSpouse);
                    await _applicationDbContext.SaveChangesAsync();
                }
            }

            return person;
        }

        public async Task<Person?> EditPersonAsync(Person updatedPerson)
        {
            var existingPerson = await _applicationDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == updatedPerson.Id);

            if (existingPerson == null)
                return null;

            existingPerson.NobleTitle = updatedPerson.NobleTitle;
            existingPerson.FirstName = updatedPerson.FirstName;
            existingPerson.LastName = updatedPerson.LastName;
            existingPerson.MaidenName = updatedPerson.MaidenName;
            existingPerson.OtherNames = updatedPerson.OtherNames;
            existingPerson.IsMale = updatedPerson.IsMale;
            existingPerson.BirthDate = updatedPerson.BirthDate;
            existingPerson.DeathDate = updatedPerson.DeathDate;
            existingPerson.BiologicalMotherId = updatedPerson.BiologicalMotherId;
            existingPerson.BiologicalFatherId = updatedPerson.BiologicalFatherId;
            existingPerson.AdoptiveMotherId = updatedPerson.AdoptiveMotherId;
            existingPerson.AdoptiveFatherId = updatedPerson.AdoptiveFatherId;
            existingPerson.FirstSpouseId = updatedPerson.FirstSpouseId;
            existingPerson.SecondSpouseId = updatedPerson.SecondSpouseId;
            existingPerson.ImageUrl = updatedPerson.ImageUrl;
            existingPerson.FirstMarriageStartDate = updatedPerson.FirstMarriageStartDate;
            existingPerson.FirstMarriageEndDate = updatedPerson.FirstMarriageEndDate;
            existingPerson.SecondMarriageStartDate = updatedPerson.SecondMarriageStartDate;
            existingPerson.SecondMarriageEndDate = updatedPerson.SecondMarriageEndDate;

            await _applicationDbContext.SaveChangesAsync();

            if (existingPerson.FirstSpouseId.HasValue)
            {
                var firstSpouse = await _applicationDbContext.Persons.FindAsync(existingPerson.FirstSpouseId.Value);
                if (firstSpouse != null)
                {
                    firstSpouse.FirstSpouseId = existingPerson.Id;
                    firstSpouse.FirstMarriageStartDate = existingPerson.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = existingPerson.FirstMarriageEndDate;

                    _applicationDbContext.Persons.Update(firstSpouse);
                    await _applicationDbContext.SaveChangesAsync();
                }
            }

            if (existingPerson.SecondSpouseId.HasValue)
            {
                var secondSpouse = await _applicationDbContext.Persons.FindAsync(existingPerson.SecondSpouseId.Value);
                if (secondSpouse != null)
                {
                    secondSpouse.SecondSpouseId = existingPerson.Id;
                    secondSpouse.SecondMarriageStartDate = existingPerson.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = existingPerson.SecondMarriageEndDate;

                    _applicationDbContext.Persons.Update(secondSpouse);
                    await _applicationDbContext.SaveChangesAsync();
                }
            }

            return existingPerson;
        }

        public async Task<bool> DeletePersonAsync(int id)
        {
            var person = await _applicationDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == id);

            if (person == null)
                return false;

            _applicationDbContext.Persons.Remove(person);

            await _applicationDbContext.SaveChangesAsync();

            return true;
        }
    }
}
