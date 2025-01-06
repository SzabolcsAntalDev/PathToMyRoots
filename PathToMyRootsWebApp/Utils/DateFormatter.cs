namespace PathToMyRootsWebApp.Utils
{
    public static class DateFormatter
    {
        private const string HumanReadableDateFormat = "yyyy. MM. dd.";

        public static string ToHumanReadableDateFormat(DateTime? dateTime)
        {
            return dateTime?.ToString(HumanReadableDateFormat) ?? "N/A";
        }
    }
}
