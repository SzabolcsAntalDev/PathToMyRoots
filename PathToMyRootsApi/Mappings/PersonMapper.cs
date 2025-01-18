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
                SpouseId = person.SpouseId,
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
                Spouse = person.Spouse == null ? null : new PersonDto
                {
                    Id = person.Spouse.Id,
                    FirstName = person.Spouse.FirstName,
                    LastName = person.Spouse.LastName
                },
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
                SpouseId = personDto.SpouseId,
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
                Spouse = personDto.Spouse == null ? null : new Person
                {
                    Id = personDto.Spouse.Id ?? PathToMyRootsApiConstants.UnsetIntValue,
                    FirstName = personDto.Spouse.FirstName,
                    LastName = personDto.Spouse.LastName,
                },
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
                SpouseId = family.SpouseId,
                Spouse = family.Spouse == null ? null : new PersonDto
                {
                    Id = family.Spouse.Id,
                    NobleTitle = family.Spouse.NobleTitle,
                    FirstName = family.Spouse.FirstName,
                    LastName = family.Spouse.LastName,
                    IsMale = family.Spouse.IsMale,
                    BiologicalMotherId = family.Spouse.BiologicalMotherId,
                    BiologicalFatherId = family.Spouse.BiologicalFatherId
                },
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
                ImageUrl = family.ImageUrl
            };
        }
    }
}
