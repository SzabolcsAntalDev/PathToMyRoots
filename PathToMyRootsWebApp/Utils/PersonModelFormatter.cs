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

            return $"{personModel.LastName} {personModel.FirstName}";
        }

        public static string ToShortFullInfo(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.UnknownValue;

            return
                $"{personModel.LastName}" + (string.IsNullOrEmpty(personModel.MaidenName) ? null : $" ({personModel.MaidenName})") + $" {personModel.FirstName} " +
                $"({DateHelper.ServerDateToYearFormat(personModel.BirthDate)}-{DateHelper.ServerDateToYearFormat(personModel.DeathDate)})";
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
