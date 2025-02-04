using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;

namespace PathToMyRootsDataAccess.Services
{
    public class FamilyHelper
    {
        private readonly PathToMyRootsDbContext _applicationDbContext;

        public FamilyHelper(PathToMyRootsDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        public async Task<Person> GetFamilyAsync(int personId)
        {
            var person = await _applicationDbContext.Persons
                .Include(p => p.InverseBiologicalMother)
                .Include(p => p.InverseBiologicalFather)
                .Include(p => p.InverseAdoptiveMother)
                .Include(p => p.InverseAdoptiveFather)
                .Include(p => p.FirstSpouse)
                .Include(p => p.SecondSpouse)
                .SingleAsync(p => p.Id == personId);

            return person;
        }
    }
}
