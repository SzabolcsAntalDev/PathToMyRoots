using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;
using System;

namespace PathToMyRootsDataAccess.Services
{
    public class PersonService
    {
        private readonly ApplicationDbContext _applicationDbContext;
        private readonly FamilyHelper _familyHelper;
        public PersonService(ApplicationDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
            _familyHelper = new FamilyHelper(_applicationDbContext);
        }

        public async Task<List<Person>> GetPersonsAsync()
        {
            var persons = await
                _applicationDbContext.Persons
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.Spouse)
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
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.Spouse)
                    .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Person> AddPersonAsync(Person person)
        {
            // Szabi: identity should be 0 cause sql insert fails otherwise
            person.Id = 0;

            await _applicationDbContext.Persons.AddAsync(person);
            await _applicationDbContext.SaveChangesAsync();

            if (person.SpouseId.HasValue)
            {
                var spouse = await _applicationDbContext.Persons.FindAsync(person.SpouseId.Value);
                if (spouse != null)
                {
                    spouse.SpouseId = person.Id;
                    spouse.MarriageDate = person.MarriageDate;

                    _applicationDbContext.Persons.Update(spouse);
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
            existingPerson.SpouseId = updatedPerson.SpouseId;
            existingPerson.ImageUrl = updatedPerson.ImageUrl;
            existingPerson.MarriageDate = updatedPerson.MarriageDate;

            await _applicationDbContext.SaveChangesAsync();

            if (existingPerson.SpouseId.HasValue)
            {
                var spouse = await _applicationDbContext.Persons.FindAsync(existingPerson.SpouseId.Value);
                if (spouse != null)
                {
                    spouse.SpouseId = existingPerson.Id;
                    spouse.MarriageDate = existingPerson.MarriageDate;

                    _applicationDbContext.Persons.Update(spouse);
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
