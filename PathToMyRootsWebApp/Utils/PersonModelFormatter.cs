using PathToMyRootsWebApp.Constants;
using PathToMyRootsWebApp.Models;

namespace PathToMyRootsWebApp.Utils
{
    public class PersonModelFormatter
    {
        public static string ToShortFullName(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return $"{personModel.LastName} {personModel.FirstName}";
        }

        public static string ToShortFullInfo(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return
                $"{personModel.LastName}" + (string.IsNullOrEmpty(personModel.MaidenName) ? null : $" ({personModel.MaidenName})") + $" {personModel.FirstName} " +
                $"({DateFormatter.ToYearDateFormat(personModel.BirthDate)}-{DateFormatter.ToYearDateFormat(personModel.DeathDate)})";
        }

        public static string ToGender(PersonModel? personModel)
        {
            if (personModel == null)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return personModel.IsMale
                ? "Male"
                : "Female";
        }
    }
}
