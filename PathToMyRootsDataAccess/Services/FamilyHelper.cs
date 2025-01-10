using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;

namespace PathToMyRootsDataAccess.Services
{
    public class FamilyHelper
    {
        private readonly ApplicationDbContext _applicationDbContext;

        public FamilyHelper(ApplicationDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<Person> GetFamilyAsync(int personId)
        {
            var person = await _applicationDbContext.Persons
                //.Include(p => p.BiologicalFather)
                //.Include(p => p.BiologicalMother)
                .Include(p => p.Spouse)
                .Include(p => p.InverseBiologicalMother)
                .Include(p => p.InverseBiologicalFather)
                //.Include(p => p.InverseBiologicalFather)
                //.Include(p => p.InverseBiologicalMother)
                //.Include(p => p.InverseSpouse)
                .SingleAsync(p => p.Id == personId);

            return person;
        }
    }
}
