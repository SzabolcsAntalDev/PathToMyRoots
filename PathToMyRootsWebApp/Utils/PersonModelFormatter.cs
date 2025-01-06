using PathToMyRootsWebApp.Models;

namespace PathToMyRootsWebApp.Utils
{
    public class PersonModelFormatter
    {
        public static string ToShortFullName(PersonModel? personModel)
        {
            if (personModel == null)
                return "N/A";

            return $"{personModel.LastName} {personModel.FirstName}";
        }

        public static string ToGender(PersonModel? personModel)
        {
            if (personModel == null)
                return "N/A";

            return personModel.IsMale
                ? "Male"
                : "Female";
        }
    }
}
