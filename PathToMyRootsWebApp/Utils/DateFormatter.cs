using PathToMyRootsWebApp.Constants;

namespace PathToMyRootsWebApp.Utils
{
    public static class DateFormatter
    {
        public static string ToHumanReadableDateFormat(DateTime? dateTime)
        {
            if (dateTime == null)
                return string.Empty;

            if (dateTime.Value == PathToMyRootsWebAppConstants.UnknownDate)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return dateTime.Value.ToString(PathToMyRootsWebAppConstants.HumanReadableDateFormat);
        }

        public static string ToYearDateFormat(DateTime? dateTime)
        {
            if (dateTime == null)
                return string.Empty;

            if (dateTime.Value == PathToMyRootsWebAppConstants.UnknownDate)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return dateTime.Value.Year.ToString();
        }
    }
}
