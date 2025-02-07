using PathToMyRootsWebApp.Constants;
using PathToMyRootsWebApp.Models;

namespace PathToMyRootsWebApp.Utils
{
    public class PersonModelFormatter
    {
        public static string ToFullNameAndBirthDate(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.UnknownValue;

            var nameParts = new List<string>();

            if (!string.IsNullOrEmpty(personModel.NobleTitle))
                nameParts.Add(personModel.NobleTitle);

            if (!string.IsNullOrEmpty(personModel.LastName))
                nameParts.Add(personModel.LastName);

            if (!string.IsNullOrEmpty(personModel.MaidenName))
                nameParts.Add($"({personModel.MaidenName})");

            nameParts.Add(personModel.FirstName);

            if (!string.IsNullOrEmpty(personModel.OtherNames))
                nameParts.Add($"{personModel.OtherNames}");

            if (personModel.BirthDate != null)
                nameParts.Add($"b. {DateHelper.ServerDateToYearFormat(personModel.BirthDate)}");

            return string.Join(" ", nameParts);
        }

        public static string ToGender(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.UnknownValue;

            return personModel.IsMale
                ? "Male"
                : "Female";
        }
    }
}
