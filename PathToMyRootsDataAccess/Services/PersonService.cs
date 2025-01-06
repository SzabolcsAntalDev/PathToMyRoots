using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;

namespace PathToMyRootsDataAccess.Services
{
    public class PersonService
    {
        private readonly ApplicationDbContext _applicationDbContext;

        public PersonService(ApplicationDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<List<Person>> GetPersonsAsync()
        {
            return await _applicationDbContext.Persons.ToListAsync();
        }

        public async Task<Person?> GetPersonAsync(int id)
        {
            return await _applicationDbContext.Persons.FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Person> AddPersonAsync(Person person)
        {
            await _applicationDbContext.Persons.AddAsync(person);
            await _applicationDbContext.SaveChangesAsync();

            return person;
        }

        public async Task<Person?> EditPersonAsync(Person updatedPerson)
        {
            var existingPerson = await _applicationDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == updatedPerson.Id);

            if (existingPerson == null)
                return null;

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

            await _applicationDbContext.SaveChangesAsync();

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
