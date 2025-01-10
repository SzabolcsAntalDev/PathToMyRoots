using PathToMyRootsSharedModels.Dtos;
using PathToMyRootsWebApp.Models;

namespace PathToMyRootsWebApp.Mappings
{
    public static class PersonModelMapper
    {
        public static PersonModel? PersonDtoToPersonModel(PersonDto? personDto)
        {
            if (personDto == null)
                return null;

            return new PersonModel()
            {
                Id = personDto.Id,
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
                BiologicalMother = personDto.BiologicalMother == null ? null : new PersonModel
                {
                    Id = personDto.BiologicalMother.Id,
                    FirstName = personDto.BiologicalMother.FirstName,
                    LastName = personDto.BiologicalMother.LastName,
                },
                BiologicalFather = personDto.BiologicalFather == null ? null : new PersonModel
                {
                    Id = personDto.BiologicalFather.Id,
                    FirstName = personDto.BiologicalFather.FirstName,
                    LastName = personDto.BiologicalFather.LastName,
                },
                Spouse = personDto.Spouse == null ? null : new PersonModel
                {
                    Id = personDto.Spouse.Id,
                    FirstName = personDto.Spouse.FirstName,
                    LastName = personDto.Spouse.LastName,
                },
            };
        }

        public static PersonDto? PersonModelToPersonDto(PersonModel personModel)
        {
            if (personModel == null)
                return null;

            return new PersonDto
            {
                Id = personModel.Id,
                FirstName = personModel.FirstName,
                LastName = personModel.LastName,
                MaidenName = personModel.MaidenName,
                OtherNames = personModel.OtherNames,
                IsMale = personModel.IsMale,
                BirthDate = personModel.BirthDate,
                DeathDate = personModel.DeathDate,
                BiologicalMotherId = personModel.BiologicalMotherId,
                BiologicalFatherId = personModel.BiologicalFatherId,
                SpouseId = personModel.SpouseId,
                BiologicalMother = personModel.BiologicalMother == null ? null : new PersonDto
                {
                    Id = personModel.BiologicalMother.Id,
                    FirstName = personModel.BiologicalMother.FirstName,
                    LastName = personModel.BiologicalMother.LastName,
                },
                BiologicalFather = personModel.BiologicalFather == null ? null : new PersonDto
                {
                    Id = personModel.BiologicalFather.Id,
                    FirstName = personModel.BiologicalFather.FirstName,
                    LastName = personModel.BiologicalFather.LastName,
                },
                Spouse = personModel.Spouse == null ? null : new PersonDto
                {
                    Id = personModel.Spouse.Id,
                    FirstName = personModel.Spouse.FirstName,
                    LastName = personModel.Spouse.LastName,
                }
            };
        }

        public static PersonModel MapFamily(PersonDto? personDto)
        {
            if (personDto == null)
            {
                return null!;
            }

            return new PersonModel
            {
                Id = personDto.Id,
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
                BiologicalMother = personDto.BiologicalMother != null ? MapFamily(personDto.BiologicalMother) : null,
                BiologicalFather = personDto.BiologicalFather != null ? MapFamily(personDto.BiologicalFather) : null,
                Spouse = personDto.Spouse != null ? MapFamily(personDto.Spouse) : null
            };
        }
    }
}
