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

        public async Task<List<Person>> GetAllPersonsAsync()
        {
            return await _applicationDbContext.Persons.ToListAsync();
        }

        public async Task<Person?> GetPersonByIdAsync(int id)
        {
            return await _applicationDbContext.Persons.FirstOrDefaultAsync(p => p.Id == id);
        }
    }
}
