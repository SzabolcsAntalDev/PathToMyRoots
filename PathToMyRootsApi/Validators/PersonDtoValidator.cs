using PathToMyRootsSharedModels.Dtos;

namespace PathToMyRootsApi.Validators
{
    public class PersonDtoValidator
    {
        private const int NamesMaxNumberOfCharacters = 50;
        private const int OhterNamesMaxNumberOfCharacters = 250;

        public static bool IsValidNotNullable(PersonDto personDto)
        {
            if (personDto == null)
                return false;

            return IsValidNullable(personDto);
        }

        private static bool IsValidNullable(PersonDto personDto)
        {
            if (personDto == null)
                return true;

            if (new[]
            {
                personDto.NobleTitle,
                personDto.FirstName,
                personDto.LastName,
                personDto.MaidenName
            }
            .Any(n => n?.Length > NamesMaxNumberOfCharacters))
                return false;

            if (personDto.OtherNames?.Length > OhterNamesMaxNumberOfCharacters)
                return false;

            if (new[]
            {
                personDto.BirthDate,
                personDto.DeathDate,
                personDto.FirstMarriageStartDate,
                personDto.FirstMarriageEndDate,
                personDto.SecondMarriageStartDate,
                personDto.SecondMarriageEndDate
            }
            .Any(d => !DatabaseDateValidator.IsValid(d)))
                return false;

            if (new[]
            {
                personDto.AdoptiveFather,
                personDto.AdoptiveMother,
                personDto.BiologicalFather,
                personDto.BiologicalMother,
                personDto.FirstSpouse,
                personDto.SecondSpouse
            }
            .Any(p => !IsValidNullable(p)))
                return false;

            var relativeIds = new List<int?>()
            {
                personDto.Id,
                personDto.BiologicalFatherId,
                personDto.BiologicalMotherId,
                personDto.AdoptiveFatherId,
                personDto.AdoptiveMotherId,
                personDto.FirstSpouseId,
                personDto.SecondSpouseId
            };

            var nonNullRelativeIds = relativeIds.Where(id => id != null).ToList();
            var allRelativeIdsAreDistinct = nonNullRelativeIds.Distinct().Count() == nonNullRelativeIds.Count;
            
            if (!allRelativeIdsAreDistinct)
                return false;

            return true;
        }
    }
}
