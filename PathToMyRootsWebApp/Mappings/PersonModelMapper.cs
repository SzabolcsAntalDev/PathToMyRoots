using PathToMyRootsSharedModels.Dtos;
using PathToMyRootsWebApp.Models;
using PathToMyRootsWebApp.Utils;

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
                BirthDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.BirthDate),
                DeathDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.DeathDate),
                BiologicalMotherId = personDto.BiologicalMotherId,
                BiologicalFatherId = personDto.BiologicalFatherId,
                AdoptiveMotherId = personDto.AdoptiveMotherId,
                AdoptiveFatherId = personDto.AdoptiveFatherId,
                FirstSpouseId = personDto.FirstSpouseId,
                SecondSpouseId = personDto.SecondSpouseId,
                FirstMarriageStartDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.FirstMarriageStartDate),
                FirstMarriageEndDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.FirstMarriageEndDate),
                SecondMarriageStartDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.SecondMarriageStartDate),
                SecondMarriageEndDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.SecondMarriageEndDate),
                BiologicalMother = ShallowPersonDtoToPersonModel(personDto.BiologicalMother),
                BiologicalFather = ShallowPersonDtoToPersonModel(personDto.BiologicalFather),
                AdoptiveMother = ShallowPersonDtoToPersonModel(personDto.AdoptiveMother),
                AdoptiveFather = ShallowPersonDtoToPersonModel(personDto.AdoptiveFather),
                FirstSpouse = ShallowPersonDtoToPersonModel(personDto.FirstSpouse),
                SecondSpouse = ShallowPersonDtoToPersonModel(personDto.SecondSpouse),
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
                BirthDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.BirthDate),
                DeathDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.DeathDate),
                BiologicalMotherId = personModel.BiologicalMotherId,
                BiologicalFatherId = personModel.BiologicalFatherId,
                AdoptiveMotherId = personModel.AdoptiveMotherId,
                AdoptiveFatherId = personModel.AdoptiveFatherId,
                FirstSpouseId = personModel.FirstSpouseId,
                SecondSpouseId = personModel.SecondSpouseId,
                FirstMarriageStartDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.FirstMarriageStartDate),
                FirstMarriageEndDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.FirstMarriageEndDate),
                SecondMarriageStartDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.SecondMarriageStartDate),
                SecondMarriageEndDate = DateHelper.ConvertServerDateToDatabaseDate(personModel.SecondMarriageEndDate),
                ImageUrl = personModel.ImageUrl
            };
        }

        private static PersonModel? ShallowPersonDtoToPersonModel(PersonDto? personDto)
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
                BirthDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.BirthDate),
                DeathDate = DateHelper.ConvertDatabaseDateToServerDate(personDto.DeathDate),
            };
        }
    }
}
