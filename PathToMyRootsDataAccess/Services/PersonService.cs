using Microsoft.EntityFrameworkCore;
using PathToMyRootsDataAccess.Models;

namespace PathToMyRootsDataAccess.Services
{
    public class PersonService
    {
        private readonly PathToMyRootsDbContext _pathToMyRootsDbContext;

        public PersonService(PathToMyRootsDbContext pathToMyRootsDbContext)
        {
            _pathToMyRootsDbContext = pathToMyRootsDbContext;
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

        public async Task<Person> AddPersonAsync(Person person)
        {
            // Szabi: identity should be 0 cause sql insert fails otherwise
            person.Id = 0;

            await _pathToMyRootsDbContext.Persons.AddAsync(person);
            await _pathToMyRootsDbContext.SaveChangesAsync();

            if (person.FirstSpouseId.HasValue)
            {
                var firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(person.FirstSpouseId.Value);
                if (firstSpouse != null)
                {
                    // Szabi: have to think about this, it's not ok like this
                    firstSpouse.FirstSpouseId = person.Id; // Szabi: is the person id given here after db save?
                    firstSpouse.FirstMarriageStartDate = person.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = person.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(firstSpouse);
                    await _pathToMyRootsDbContext.SaveChangesAsync();
                }
            }

            if (person.SecondSpouseId.HasValue)
            {
                var secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(person.SecondSpouseId.Value);
                if (secondSpouse != null)
                {
                    secondSpouse.SecondSpouseId = person.Id;
                    secondSpouse.SecondMarriageStartDate = person.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = person.SecondMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(secondSpouse);
                    await _pathToMyRootsDbContext.SaveChangesAsync();
                }
            }

            return person;
        }

        public async Task<Person?> EditPersonAsync(Person personFromServer)
        {
            var personFromDb = await _pathToMyRootsDbContext.Persons
                .FirstOrDefaultAsync(p => p.Id == personFromServer.Id);

            if (personFromDb == null)
                return null;

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

            await _pathToMyRootsDbContext.SaveChangesAsync();

            if (personFromDb.FirstSpouseId.HasValue)
            {
                var firstSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.FirstSpouseId.Value);
                if (firstSpouse != null)
                {
                    firstSpouse.FirstSpouseId = personFromDb.Id;
                    firstSpouse.FirstMarriageStartDate = personFromDb.FirstMarriageStartDate;
                    firstSpouse.FirstMarriageEndDate = personFromDb.FirstMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(firstSpouse);
                    await _pathToMyRootsDbContext.SaveChangesAsync();
                }
            }

            if (personFromDb.SecondSpouseId.HasValue)
            {
                var secondSpouse = await _pathToMyRootsDbContext.Persons.FindAsync(personFromDb.SecondSpouseId.Value);
                if (secondSpouse != null)
                {
                    secondSpouse.SecondSpouseId = personFromDb.Id;
                    secondSpouse.SecondMarriageStartDate = personFromDb.SecondMarriageStartDate;
                    secondSpouse.SecondMarriageEndDate = personFromDb.SecondMarriageEndDate;

                    _pathToMyRootsDbContext.Persons.Update(secondSpouse);
                    await _pathToMyRootsDbContext.SaveChangesAsync();
                }
            }

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
