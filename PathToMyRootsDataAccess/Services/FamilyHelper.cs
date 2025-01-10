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
                .Include(p => p.BiologicalFather)
                .Include(p => p.BiologicalMother)
                .Include(p => p.Spouse)
                .SingleAsync(p => p.Id == personId);

            await LoadAncestorsAsync(person);

            return person;
        }

        private async Task LoadAncestorsAsync(Person person)
        {
            if (person.BiologicalMotherId.HasValue)
            {
                person.BiologicalMother = await _applicationDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.Spouse)
                    .SingleOrDefaultAsync(p => p.Id == person.BiologicalMotherId);

                await LoadAncestorsAsync(person.BiologicalMother!);
            }

            if (person.BiologicalFatherId.HasValue)
            {
                person.BiologicalFather = await _applicationDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.Spouse)
                    .SingleOrDefaultAsync(p => p.Id == person.BiologicalFatherId);

                await LoadAncestorsAsync(person.BiologicalFather!);
            }

            if (person.SpouseId.HasValue)
            {
                person.Spouse = await _applicationDbContext.Persons
                    .Include(p => p.BiologicalFather)
                    .Include(p => p.BiologicalMother)
                    .Include(p => p.Spouse)
                    .SingleOrDefaultAsync(p => p.Id == person.SpouseId);

                await LoadAncestorsAsync(person.Spouse!);
            }
        }
    }
}
