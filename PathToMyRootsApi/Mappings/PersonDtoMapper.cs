using PathToMyRootsApi.Constants;
using PathToMyRootsDataAccess.Models;
using PathToMyRootsSharedModels.Dtos;

namespace PathToMyRootsApi.Mappings
{
    public class PersonDtoMapper
    {
        public static PersonDto PersonToPersonDto(Person person)
        {
            return new PersonDto()
            {
                Id = person.Id,
                NobleTitle = person.NobleTitle,
                FirstName = person.FirstName,
                LastName = person.LastName,
                MaidenName = person.MaidenName,
                OtherNames = person.OtherNames,
                IsMale = person.IsMale,
                BirthDate = person.BirthDate,
                DeathDate = person.DeathDate,
                BiologicalMotherId = person.BiologicalMotherId,
                BiologicalFatherId = person.BiologicalFatherId,
                AdoptiveMotherId = person.AdoptiveMotherId,
                AdoptiveFatherId = person.AdoptiveFatherId,
                FirstSpouseId = person.FirstSpouseId,
                SecondSpouseId = person.SecondSpouseId,
                FirstMarriageStartDate = person.FirstMarriageStartDate,
                FirstMarriageEndDate = person.FirstMarriageEndDate,
                SecondMarriageStartDate = person.SecondMarriageStartDate,
                SecondMarriageEndDate = person.SecondMarriageEndDate,
                BiologicalMother = ShallowPersonToPersonDto(person.BiologicalMother),
                BiologicalFather = ShallowPersonToPersonDto(person.BiologicalFather),
                AdoptiveMother = ShallowPersonToPersonDto(person.AdoptiveMother),
                AdoptiveFather = ShallowPersonToPersonDto(person.AdoptiveFather),
                FirstSpouse = ShallowPersonToPersonDto(person.FirstSpouse),
                SecondSpouse = ShallowPersonToPersonDto(person.SecondSpouse),
                InverseBiologicalFather = person.InverseBiologicalFather.Select(c => ShallowPersonToPersonDto(c)!).ToList(),
                InverseBiologicalMother = person.InverseBiologicalMother.Select(c => ShallowPersonToPersonDto(c)!).ToList(),
                InverseAdoptiveFather = person.InverseAdoptiveFather.Select(c => ShallowPersonToPersonDto(c)!).ToList(),
                InverseAdoptiveMother = person.InverseAdoptiveMother.Select(c => ShallowPersonToPersonDto(c)!).ToList(),
                ImageUrl = person.ImageUrl
            };
        }

        public static Person PersonDtoToPerson(PersonDto personDto)
        {
            return new Person
            {
                Id = personDto.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                NobleTitle = personDto.NobleTitle,
                FirstName = personDto.FirstName,
                LastName = personDto.LastName,
                MaidenName = personDto.MaidenName,
                OtherNames = personDto.OtherNames,
                IsMale = personDto.IsMale,
                BirthDate = personDto.BirthDate,
                DeathDate = personDto.DeathDate,
                BiologicalMotherId = personDto.BiologicalMotherId,
                BiologicalFatherId = personDto.BiologicalFatherId,
                AdoptiveMotherId = personDto.AdoptiveMotherId,
                AdoptiveFatherId = personDto.AdoptiveFatherId,
                FirstSpouseId = personDto.FirstSpouseId,
                SecondSpouseId = personDto.SecondSpouseId,
                FirstMarriageStartDate = personDto.FirstMarriageStartDate,
                FirstMarriageEndDate = personDto.FirstMarriageEndDate,
                SecondMarriageStartDate = personDto.SecondMarriageStartDate,
                SecondMarriageEndDate = personDto.SecondMarriageEndDate,
                ImageUrl = personDto.ImageUrl
            };
        }

        private static PersonDto? ShallowPersonToPersonDto(Person? person)
        {
            if (person == null)
                return null;

            return new PersonDto
            {
                Id = person.Id,
                FirstName = person.FirstName,
                LastName = person.LastName,
                MaidenName = person.MaidenName,
                OtherNames = person.OtherNames,
                BirthDate = person.BirthDate,
                DeathDate = person.DeathDate,
                BiologicalFatherId = person.BiologicalFatherId,
                BiologicalMotherId = person.BiologicalMotherId,
                AdoptiveFatherId = person.AdoptiveFatherId,
                AdoptiveMotherId = person.AdoptiveMotherId,
            };
        }
    }
}
