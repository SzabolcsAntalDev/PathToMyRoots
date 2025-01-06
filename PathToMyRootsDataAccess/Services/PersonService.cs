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

        public async Task<Person?> GetPersonByIdAsync(int id)
        {
            return await _applicationDbContext.Persons.FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Person> AddPersonAsync(Person person)
        {
            await _applicationDbContext.Persons.AddAsync(person);
            await _applicationDbContext.SaveChangesAsync();

            return person;
        }
    }
}
