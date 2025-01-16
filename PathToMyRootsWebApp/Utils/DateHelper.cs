using NodaTime;
using System.Globalization;

namespace PathToMyRootsWebApp.Utils
{
    public static class DateHelper
    {
        #region Constants
        public const string HumanReadableDateStillAlive = "Alive";
        public const string HumanReadableDateUnknownDate = "?";

        public const string InputDateFormat = "{0}-{1}-{2}";
        public const string ServerDateFormatFormat = "+{0}{1}{2}";
        public const string InputDateValidationPattern = "^\\\\d{4}-(\\\\d{2}|mm)-(\\\\d{2}|dd)$";
        public const string InputDateFlatFormat = "yyyy-mm-dd";

        private const string MonthNumberPlaceHolder = "mm";
        private const string DayNumberPlaceHolder = "dd";

        public static readonly string UnknownInputDate = "yyyy-mm-dd";
        public static readonly string UnknownServerDate = "+yyyymmdd";
        #endregion

        public static string ServerDateToInputDate(string? date)
        {
            if (date == null)
                return InputDateFlatFormat;

            return string.Format(InputDateFormat, GetStringValuesFromServerDate(date));
        }

        public static string? InputDateToServerDate(string? date)
        {
            if (date == null)
                return null;

            return string.Format(ServerDateFormatFormat, GetStringValuesFromInputDate(date));
        }

        public static bool IsServerDateValid(string? date, out string errorMessage)
        {
            errorMessage = string.Empty;
            if (date == null || date == UnknownServerDate)
                return true;

            var yearNumber = int.Parse(GetYearStringFromServerDate(date));

            var monthString = GetMonthStringFromServerDate(date);
            var dayString = GetDayStringFromServerDate(date);

            if (monthString == MonthNumberPlaceHolder)
            {
                if (dayString != DayNumberPlaceHolder)
                {
                    errorMessage = "Invalid date format: if day is set then month should also be set.";
                    return false;
                }

                return true;
            }

            int monthNumber = int.Parse(monthString);
            if (monthNumber > 12)
            {
                errorMessage = "Invalid date format: month number too big.";
                return false;
            }

            if (dayString == DayNumberPlaceHolder)
                return true;

            int dayNumber = int.Parse(dayString);
            try
            {
                new LocalDate(yearNumber, monthNumber, dayNumber);
                return true;
            }
            catch (Exception ex)
            {
                errorMessage = $"Invalid date format: {ex.Message}";
                return false;
            }
        }

        public static string ServerDateToHumanReadableDateFormat(string? date)
        {
            if (date == null)
                return string.Empty;

            if (date == UnknownServerDate)
                return HumanReadableDateUnknownDate;

            var result = GetYearStringFromServerDate(date);

            var monthString = GetMonthStringFromServerDate(date);
            if (monthString == MonthNumberPlaceHolder)
                return result;

            result += ". " + CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(int.Parse(monthString)).Substring(0, 3) + ".";

            var dayString = GetDayStringFromServerDate(date);
            if (dayString == DayNumberPlaceHolder)
                return result;

            return result += " " + int.Parse(dayString) + ".";
        }

        public static string ServerDateToYearFormat(string? date)
        {
            if (date == null)
                return string.Empty;

            if (date == UnknownServerDate)
                return HumanReadableDateUnknownDate;

            return GetYearStringFromServerDate(date);
        }

        #region Private methods
        private static string[] GetStringValuesFromServerDate(string date)
        {
            return
            [
                GetYearStringFromServerDate(date),
                GetMonthStringFromServerDate(date),
                GetDayStringFromServerDate(date),
            ];
        }
        private static string GetYearStringFromServerDate(string date)
        {
            return date.AsSpan(1, 4).ToString();
        }
        private static string GetMonthStringFromServerDate(string date)
        {
            return date.AsSpan(5, 2).ToString();
        }
        private static string GetDayStringFromServerDate(string date)
        {
            return date.AsSpan(7, 2).ToString();
        }

        private static string[] GetStringValuesFromInputDate(string date)
        {
            return
            [
                GetYearStringFromInputDate(date),
                GetMonthStringFromInputDate(date),
                GetDayStringFromInputDate(date),
            ];
        }
        private static string GetYearStringFromInputDate(string date)
        {
            return date.AsSpan(0, 4).ToString();
        }
        private static string GetMonthStringFromInputDate(string date)
        {
            return date.AsSpan(5, 2).ToString();
        }
        private static string GetDayStringFromInputDate(string date)
        {
            return date.AsSpan(8, 2).ToString();
        }
        #endregion Private methods
    }
}
