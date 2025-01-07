using PathToMyRootsWebApp.Constants;

namespace PathToMyRootsWebApp.Utils
{
    public static class DateFormatter
    {
        public static string ToHumanReadableDateFormat(DateTime? dateTime)
        {
            return dateTime?.ToString(PathToMyRootsWebAppConstants.HumanReadableDateFormat) ?? PathToMyRootsWebAppConstants.ValueNotAvailable;
        }
    }
}
