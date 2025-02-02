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
                AdoptiveMother = personDto.AdoptiveMother == null ? null : new PersonModel
                {
                    Id = personDto.AdoptiveMother.Id,
                    FirstName = personDto.AdoptiveMother.FirstName,
                    LastName = personDto.AdoptiveMother.LastName,
                },
                AdoptiveFather = personDto.AdoptiveFather == null ? null : new PersonModel
                {
                    Id = personDto.AdoptiveFather.Id,
                    FirstName = personDto.AdoptiveFather.FirstName,
                    LastName = personDto.AdoptiveFather.LastName,
                },
                Spouse = personDto.Spouse == null ? null : new PersonModel
                {
                    Id = personDto.Spouse.Id,
                    FirstName = personDto.Spouse.FirstName,
                    LastName = personDto.Spouse.LastName,
                },
                MarriageDate = personDto.MarriageDate,
                ImageUrl = personDto.ImageUrl
            };
        }

        public static PersonDto? PersonModelToPersonDto(PersonModel personModel)
        {
            if (personModel == null)
                return null;

            return new PersonDto
            {
                Id = personModel.Id,
                NobleTitle = personModel.NobleTitle,
                FirstName = personModel.FirstName,
                LastName = personModel.LastName,
                MaidenName = personModel.MaidenName,
                OtherNames = personModel.OtherNames,
                IsMale = personModel.IsMale,
                BirthDate = personModel.BirthDate,
                DeathDate = personModel.DeathDate,
                BiologicalMotherId = personModel.BiologicalMotherId,
                BiologicalFatherId = personModel.BiologicalFatherId,
                AdoptiveMotherId = personModel.AdoptiveMotherId,
                AdoptiveFatherId = personModel.AdoptiveFatherId,
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
                AdoptiveMother = personModel.AdoptiveMother == null ? null : new PersonDto
                {
                    Id = personModel.AdoptiveMother.Id,
                    FirstName = personModel.AdoptiveMother.FirstName,
                    LastName = personModel.AdoptiveMother.LastName,
                },
                AdoptiveFather = personModel.AdoptiveFather == null ? null : new PersonDto
                {
                    Id = personModel.AdoptiveFather.Id,
                    FirstName = personModel.AdoptiveFather.FirstName,
                    LastName = personModel.AdoptiveFather.LastName,
                },
                Spouse = personModel.Spouse == null ? null : new PersonDto
                {
                    Id = personModel.Spouse.Id,
                    FirstName = personModel.Spouse.FirstName,
                    LastName = personModel.Spouse.LastName,
                },
                MarriageDate = personModel.MarriageDate,
                ImageUrl = personModel.ImageUrl
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
                SpouseId = personDto.SpouseId,
                Spouse = personDto.Spouse == null ? null : new PersonModel
                {
                    Id = personDto.Spouse.Id,
                    FirstName = personDto.Spouse.FirstName,
                    LastName = personDto.Spouse.LastName,
                },
                MarriageDate = personDto.MarriageDate,
                ImageUrl = personDto.ImageUrl
            };
        }
    }
}
