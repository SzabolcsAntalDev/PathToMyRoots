using PathToMyRootsDataAccess.Models;
using PathToMyRootsSharedModels.Dtos;

namespace PathToMyRootsApi.Mappings
{
    public class PersonMapper
    {
        public static PersonDto? PersonToPersonDto(Person? person)
        {
            if (person == null)
                return null;

            return new PersonDto()
            {
                FirstName = person.FirstName,
                LastName = person.LastName,
                MaidenName = person.MaidenName,
                OtherNames = person.OtherNames,
                IsMale = person.IsMale,
                BirthDate = person.BirthDate,
                DeathDate = person.DeathDate,
                BiologicalMotherId = person.BiologicalMotherId,
                BiologicalFatherId = person.BiologicalFatherId,
                SpouseId = person.SpouseId,
                BiologicalMother = person.BiologicalMother == null ? null : new PersonDto
                {
                    FirstName = person.BiologicalMother.FirstName,
                    LastName = person.BiologicalMother.LastName,
                    IsMale = person.BiologicalMother.IsMale,
                    BirthDate = person.BiologicalMother.BirthDate,
                    DeathDate = person.BiologicalMother.DeathDate
                },
                BiologicalFather = person.BiologicalFather == null ? null : new PersonDto
                {
                    FirstName = person.BiologicalFather.FirstName,
                    LastName = person.BiologicalFather.LastName,
                    IsMale = person.BiologicalFather.IsMale,
                    BirthDate = person.BiologicalFather.BirthDate,
                    DeathDate = person.BiologicalFather.DeathDate
                },
                Spouse = person.Spouse == null ? null : new PersonDto
                {
                    FirstName = person.Spouse.FirstName,
                    LastName = person.Spouse.LastName,
                    IsMale = person.Spouse.IsMale,
                    BirthDate = person.Spouse.BirthDate,
                    DeathDate = person.Spouse.DeathDate
                }
            };
        }

        public static Person? PersonDtoToPerson(PersonDto personDto)
        {
            if (personDto == null)
                return null;

            return new Person
            {
                FirstName = personDto.FirstName,
                LastName = personDto.LastName,
                MaidenName = personDto.MaidenName,
                OtherNames = personDto.OtherNames,
                IsMale = personDto.IsMale,
                BirthDate = personDto.BirthDate,
                DeathDate = personDto.DeathDate,
                BiologicalMotherId = personDto.BiologicalMotherId,
                BiologicalFatherId = personDto.BiologicalFatherId,
                SpouseId = personDto.SpouseId,

                BiologicalMother = personDto.BiologicalMother == null ? null : new Person
                {
                    FirstName = personDto.BiologicalMother.FirstName,
                    LastName = personDto.BiologicalMother.LastName,
                    IsMale = personDto.BiologicalMother.IsMale,
                    BirthDate = personDto.BiologicalMother.BirthDate,
                    DeathDate = personDto.BiologicalMother.DeathDate
                },
                BiologicalFather = personDto.BiologicalFather == null ? null : new Person
                {
                    FirstName = personDto.BiologicalFather.FirstName,
                    LastName = personDto.BiologicalFather.LastName,
                    IsMale = personDto.BiologicalFather.IsMale,
                    BirthDate = personDto.BiologicalFather.BirthDate,
                    DeathDate = personDto.BiologicalFather.DeathDate
                },
                Spouse = personDto.Spouse == null ? null : new Person
                {
                    FirstName = personDto.Spouse.FirstName,
                    LastName = personDto.Spouse.LastName,
                    IsMale = personDto.Spouse.IsMale,
                    BirthDate = personDto.Spouse.BirthDate,
                    DeathDate = personDto.Spouse.DeathDate
                }
            };
        }
    }
}
