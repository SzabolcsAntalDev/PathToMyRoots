using PathToMyRootsApi.Constants;
using PathToMyRootsApi.Helpers;
using PathToMyRootsDataAccess.Models;
using PathToMyRootsSharedModels.Dtos;
using System;

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
                BiologicalMother = person.BiologicalMother == null ? null : new PersonDto
                {
                    Id = person.BiologicalMother.Id,
                    FirstName = person.BiologicalMother.FirstName,
                    LastName = person.BiologicalMother.LastName,
                },
                BiologicalFather = person.BiologicalFather == null ? null : new PersonDto
                {
                    Id = person.BiologicalFather.Id,
                    FirstName = person.BiologicalFather.FirstName,
                    LastName = person.BiologicalFather.LastName,
                },
                AdoptiveMother = person.AdoptiveMother == null ? null : new PersonDto
                {
                    Id = person.AdoptiveMother.Id,
                    FirstName = person.AdoptiveMother.FirstName,
                    LastName = person.AdoptiveMother.LastName,
                },
                AdoptiveFather = person.AdoptiveFather == null ? null : new PersonDto
                {
                    Id = person.AdoptiveFather.Id,
                    FirstName = person.AdoptiveFather.FirstName,
                    LastName = person.AdoptiveFather.LastName,
                },
                FirstSpouse = person.FirstSpouse == null ? null : new PersonDto
                {
                    Id = person.FirstSpouse.Id,
                    FirstName = person.FirstSpouse.FirstName,
                    LastName = person.FirstSpouse.LastName
                },
                SecondSpouse = person.SecondSpouse == null ? null : new PersonDto
                {
                    Id = person.SecondSpouse.Id,
                    FirstName = person.SecondSpouse.FirstName,
                    LastName = person.SecondSpouse.LastName
                },
                FirstMarriageStartDate = person.FirstMarriageStartDate,
                FirstMarriageEndDate = person.FirstMarriageEndDate,
                SecondMarriageStartDate = person.SecondMarriageStartDate,
                SecondMarriageEndDate = person.SecondMarriageEndDate,
                ImageUrl = person.ImageUrl
            };
        }

        public static Person? PersonDtoToPerson(PersonDto personDto)
        {
            if (personDto == null)
                return null;

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
                BiologicalMother = personDto.BiologicalMother == null ? null : new Person
                {
                    Id = personDto.BiologicalMother.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.BiologicalMother.FirstName,
                    LastName = personDto.BiologicalMother.LastName,
                },
                BiologicalFather = personDto.BiologicalFather == null ? null : new Person
                {
                    Id = personDto.BiologicalFather.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.BiologicalFather.FirstName,
                    LastName = personDto.BiologicalFather.LastName,
                },
                AdoptiveMother = personDto.AdoptiveMother == null ? null : new Person
                {
                    Id = personDto.AdoptiveMother.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.AdoptiveMother.FirstName,
                    LastName = personDto.AdoptiveMother.LastName,
                },
                AdoptiveFather = personDto.AdoptiveFather == null ? null : new Person
                {
                    Id = personDto.AdoptiveFather.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.AdoptiveFather.FirstName,
                    LastName = personDto.AdoptiveFather.LastName,
                },
                FirstSpouse = personDto.FirstSpouse == null ? null : new Person
                {
                    Id = personDto.FirstSpouse.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.FirstSpouse.FirstName,
                    LastName = personDto.FirstSpouse.LastName,
                },
                SecondSpouse = personDto.SecondSpouse == null ? null : new Person
                {
                    Id = personDto.SecondSpouse.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.SecondSpouse.FirstName,
                    LastName = personDto.SecondSpouse.LastName,
                },
                FirstMarriageStartDate = personDto.FirstMarriageStartDate,
                FirstMarriageEndDate = personDto.FirstMarriageEndDate,
                SecondMarriageStartDate = personDto.SecondMarriageStartDate,
                SecondMarriageEndDate = personDto.SecondMarriageEndDate,
                ImageUrl = personDto.ImageUrl
            };
        }

        public static PersonDto MapFamily(Person family)
        {
            if (family == null)
            {
                return null!;
            }

            return new PersonDto
            {
                Id = family.Id,
                NobleTitle = family.NobleTitle,
                FirstName = family.FirstName,
                LastName = family.LastName,
                MaidenName = family.MaidenName,
                OtherNames = family.OtherNames,
                IsMale = family.IsMale,
                BirthDate = family.BirthDate,
                DeathDate = family.DeathDate,
                BiologicalMotherId = family.BiologicalMotherId,
                BiologicalFatherId = family.BiologicalFatherId,
                AdoptiveMotherId = family.AdoptiveMotherId,
                AdoptiveFatherId = family.AdoptiveFatherId,
                FirstSpouseId = family.FirstSpouseId,
                SecondSpouseId = family.SecondSpouseId,
                FirstSpouse = family.FirstSpouse == null ? null : new PersonDto
                {
                    Id = family.FirstSpouse.Id,
                    NobleTitle = family.FirstSpouse.NobleTitle,
                    FirstName = family.FirstSpouse.FirstName,
                    LastName = family.FirstSpouse.LastName,
                    IsMale = family.FirstSpouse.IsMale,
                    BiologicalFatherId = family.FirstSpouse.BiologicalFatherId,
                    BiologicalMotherId = family.FirstSpouse.BiologicalMotherId,
                    AdoptiveFatherId = family.FirstSpouse.AdoptiveFatherId,
                    AdoptiveMotherId = family.FirstSpouse.AdoptiveMotherId
                },
                SecondSpouse = family.SecondSpouse == null ? null : new PersonDto
                {
                    Id = family.SecondSpouse.Id,
                    NobleTitle = family.SecondSpouse.NobleTitle,
                    FirstName = family.SecondSpouse.FirstName,
                    LastName = family.SecondSpouse.LastName,
                    IsMale = family.SecondSpouse.IsMale,
                    BiologicalFatherId = family.SecondSpouse.BiologicalFatherId,
                    BiologicalMotherId = family.SecondSpouse.BiologicalMotherId,
                    AdoptiveFatherId = family.SecondSpouse.AdoptiveFatherId,
                    AdoptiveMotherId = family.SecondSpouse.AdoptiveMotherId
                },
                FirstMarriageStartDate = family.FirstMarriageStartDate,
                FirstMarriageEndDate = family.FirstMarriageEndDate,
                SecondMarriageStartDate = family.SecondMarriageStartDate,
                SecondMarriageEndDate = family.SecondMarriageEndDate,
                InverseBiologicalMother =
                    family.InverseBiologicalMother
                        .Select(child => new PersonDto
                        {
                            Id = child.Id,
                            NobleTitle = child.NobleTitle,
                            FirstName = child.FirstName,
                            LastName = child.LastName,
                            BiologicalMotherId = child.BiologicalMotherId,
                            BiologicalFatherId = child.BiologicalFatherId
                        }).ToList(),
                InverseBiologicalFather = family.InverseBiologicalFather
                        .Select(child => new PersonDto
                        {
                            Id = child.Id,
                            NobleTitle = child.NobleTitle,
                            FirstName = child.FirstName,
                            LastName = child.LastName,
                            BiologicalMotherId = child.BiologicalMotherId,
                            BiologicalFatherId = child.BiologicalFatherId
                        }).ToList(),
                InverseAdoptiveMother =
                    family.InverseAdoptiveMother
                        .Select(child => new PersonDto
                        {
                            Id = child.Id,
                            NobleTitle = child.NobleTitle,
                            FirstName = child.FirstName,
                            LastName = child.LastName,
                            AdoptiveMotherId = child.AdoptiveMotherId,
                            AdoptiveFatherId = child.AdoptiveFatherId
                        }).ToList(),
                InverseAdoptiveFather = family.InverseAdoptiveFather
                        .Select(child => new PersonDto
                        {
                            Id = child.Id,
                            NobleTitle = child.NobleTitle,
                            FirstName = child.FirstName,
                            LastName = child.LastName,
                            AdoptiveMotherId = child.AdoptiveMotherId,
                            AdoptiveFatherId = child.AdoptiveFatherId
                        }).ToList(),
                ImageUrl = family.ImageUrl
            };
        }
    }
}
