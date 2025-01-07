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
