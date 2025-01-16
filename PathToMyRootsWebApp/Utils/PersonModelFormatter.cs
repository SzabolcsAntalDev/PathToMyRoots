using PathToMyRootsWebApp.Constants;
using PathToMyRootsWebApp.Models;

namespace PathToMyRootsWebApp.Utils
{
    public class PersonModelFormatter
    {
        public static string ToShortFullName(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.UnknownValue;

            var nameParts = new List<string>();

            if (!string.IsNullOrEmpty(personModel.NobleTitle))
                nameParts.Add(personModel.NobleTitle);

            if (!string.IsNullOrEmpty(personModel.LastName))
                nameParts.Add(personModel.LastName);

            nameParts.Add(personModel.FirstName);

            return string.Join(" ", nameParts);
        }

        public static string ToShortFullInfo(PersonModel? personModel)
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

            nameParts.Add($"({DateHelper.ServerDateToYearFormat(personModel.BirthDate)}-{DateHelper.ServerDateToYearFormat(personModel.DeathDate)})");

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
