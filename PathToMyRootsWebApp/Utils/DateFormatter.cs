using PathToMyRootsWebApp.Constants;

namespace PathToMyRootsWebApp.Utils
{
    public static class DateFormatter
    {
        public static string DatabaseDateTimeToHumanReadableDateFormat(string? dateTime)
        {
            if (dateTime == null)
                return string.Empty;

            if (dateTime == PathToMyRootsWebAppConstants.UnknownDate)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return string.Format(PathToMyRootsWebAppConstants.HumanReadableDateFormat, GetValuesFromDataBaseDateTime(dateTime));
        }

        public static string DatabaseDateTimeToYearDateFormat(string? dateTime)
        {
            if (dateTime == null)
                return string.Empty;

            if (dateTime == PathToMyRootsWebAppConstants.UnknownDate)
                return PathToMyRootsWebAppConstants.ValueNotAvailable;

            return GetYearFromDatabaseDateTime(dateTime);
        }

        private static string[] GetValuesFromDataBaseDateTime(string dateTime)
        {
            return
            [
                GetYearFromDatabaseDateTime  (dateTime),
                GetMonthFromDatabaseDateTime (dateTime),
                GetDayFromDatabaseDateTime(dateTime),
            ];
        }

        private static string GetYearFromDatabaseDateTime(string dateTime)
        {
            return dateTime.AsSpan(1, 4).ToString();
        }
        private static string GetMonthFromDatabaseDateTime(string dateTime)
        {
            return dateTime.AsSpan(5, 2).ToString();
        }
        private static string GetDayFromDatabaseDateTime(string dateTime)
        {
            return dateTime.AsSpan(7, 2).ToString();
        }

        private static string[] GetValuesFromInputDateTime(string dateTime)
        {
            return
            [
                GetYearFromInputDateTime  (dateTime),
                GetMonthFromInputDateTime (dateTime),
                GetDayFromInputDateTime(dateTime),
            ];
        }

        private static string GetYearFromInputDateTime(string dateTime)
        {
            return dateTime.AsSpan(0, 4).ToString();
        }
        private static string GetMonthFromInputDateTime(string dateTime)
        {
            return dateTime.AsSpan(5, 2).ToString();
        }
        private static string GetDayFromInputDateTime(string dateTime)
        {
            return dateTime.AsSpan(8, 2).ToString();
        }

        public static string DatabaseDateTimeToDateInputText(string? dateTime)
        {
            if (dateTime == null)
                return PathToMyRootsWebAppConstants.DateInputFlatFormat;

            return string.Format(PathToMyRootsWebAppConstants.DateInputFormat, GetValuesFromDataBaseDateTime(dateTime));
        }

        public static string? DateInputToDataBaseFormat(string? dateTime)
        {
            if (dateTime == null)
                return null;

            return string.Format(PathToMyRootsWebAppConstants.DateDatabaseFormat, GetValuesFromInputDateTime(dateTime));
        }
    }
}
