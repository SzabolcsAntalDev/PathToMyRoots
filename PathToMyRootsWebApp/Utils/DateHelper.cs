using NodaTime;
using System.Globalization;

namespace PathToMyRootsWebApp.Utils
{
    public static class DateHelper
    {
        #region Constants
        public const string HumanReadableDateStillAlive = "Alive";
        public const string HumanReadableDateUnknownDate = "?";
        public const string HumanReadableDateMissingDate = "";

        public const string ServerDateFormat = "{0}-{1}-{2}";
        public const string DatabaseDateFormat = "+{0}{1}{2}";

        public const string ServerDateUnknown = "yyyy-mm-dd";
        public const string DatabaseDateUnknown = "+yyyymmdd";

        public const string ServerDateInputValidationPattern = "^\\\\d{4}-(\\\\d{2}|mm)-(\\\\d{2}|dd)$";

        private const string MonthNumberPlaceHolder = "mm";
        private const string DayNumberPlaceHolder = "dd";
        #endregion

        public static string? ConvertDatabaseDateToServerDate(string? datebaseDate)
        {
            if (datebaseDate == null)
                return null;

            return string.Format(ServerDateFormat, GetStringValuesFromDatabaseDate(datebaseDate));
        }

        public static string? ConvertServerDateToDatabaseDate(string? serverDate)
        {
            if (serverDate == null)
                return null;

            return string.Format(DatabaseDateFormat, GetStringValuesFromServerDate(serverDate));
        }

        public static string? GetServerDateValidationErrorMessage(string? serverDate)
        {
            if (serverDate == null || serverDate == ServerDateUnknown)
                return null;

            if (serverDate.Length != ServerDateUnknown.Length)
                return $"The date does not match the format {ServerDateUnknown}.";

            int yearNumber = 0;
            try
            {
                yearNumber = int.Parse(GetYearStringFromServerDate(serverDate));
            }
            catch
            {
                return $"The year number does not match the format {ServerDateUnknown}.";
            }

            var monthString = GetMonthStringFromServerDate(serverDate);
            var dayString = GetDayStringFromServerDate(serverDate);

            if (monthString == MonthNumberPlaceHolder)
            {
                if (dayString != DayNumberPlaceHolder)
                {
                    return "In case the day is set, the month must also be specified.";
                }

                return null;
            }

            int monthNumber = 0;
            try
            {
                monthNumber = int.Parse(monthString);
            }
            catch
            {
                return $"The month number does not match the format {ServerDateUnknown}.";
            }

            if (monthNumber < 1 || monthNumber > 12)
            {
                return "The month number should be a number between 1 and 12.";
            }

            if (dayString == DayNumberPlaceHolder)
                return null;

            int dayNumber = 0;
            try
            {
                dayNumber = int.Parse(dayString);
            }
            catch
            {
                return $"The day number does not match the format {ServerDateUnknown}.";
            }

            if (dayNumber < 1 || dayNumber > 31)
            {
                return "The day number should be a number between 1 and 31.";
            }

            try
            {
                new LocalDate(yearNumber, monthNumber, dayNumber);
                return null;
            }
            catch
            {
                return "The provided date is not valid.";
            }
        }

        public static string ConvertDatabaseDateToHumanReadableDateFormat(string? databaseDate)
        {
            if (databaseDate == null)
                return string.Empty;

            if (databaseDate == DatabaseDateUnknown)
                return HumanReadableDateUnknownDate;

            var result = GetYearStringFromDatabaseDate(databaseDate);

            var monthString = GetMonthStringFromDatabaseDate(databaseDate);
            if (monthString == MonthNumberPlaceHolder)
                return result;

            result += ". " + CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(int.Parse(monthString)).Substring(0, 3) + ".";

            var dayString = GetDayStringFromDatabaseDate(databaseDate);
            if (dayString == DayNumberPlaceHolder)
                return result;

            return result += " " + int.Parse(dayString) + ".";
        }

        public static string ConvertServerDateToYearFormat(string? serverDate)
        {
            if (serverDate == null)
                return string.Empty;

            if (serverDate == ServerDateUnknown)
                return HumanReadableDateUnknownDate;

            return GetYearStringFromServerDate(serverDate);
        }

        #region Private methods
        private static string[] GetStringValuesFromDatabaseDate(string databaseDate)
        {
            return
            [
                GetYearStringFromDatabaseDate(databaseDate),
                GetMonthStringFromDatabaseDate(databaseDate),
                GetDayStringFromDatabaseDate(databaseDate),
            ];
        }
        private static string GetYearStringFromDatabaseDate(string databaseDate)
        {
            return databaseDate.AsSpan(1, 4).ToString();
        }
        private static string GetMonthStringFromDatabaseDate(string databaseDate)
        {
            return databaseDate.AsSpan(5, 2).ToString();
        }
        private static string GetDayStringFromDatabaseDate(string datebaseDate)
        {
            return datebaseDate.AsSpan(7, 2).ToString();
        }

        private static string[] GetStringValuesFromServerDate(string serverDate)
        {
            return
            [
                GetYearStringFromServerDate(serverDate),
                GetMonthStringFromServerDate(serverDate),
                GetDayStringFromServerDate(serverDate),
            ];
        }
        private static string GetYearStringFromServerDate(string serverDate)
        {
            return serverDate.AsSpan(0, 4).ToString();
        }
        private static string GetMonthStringFromServerDate(string serverDate)
        {
            return serverDate.AsSpan(5, 2).ToString();
        }
        private static string GetDayStringFromServerDate(string serverDate)
        {
            return serverDate.AsSpan(8, 2).ToString();
        }
        #endregion Private methods
    }
}
