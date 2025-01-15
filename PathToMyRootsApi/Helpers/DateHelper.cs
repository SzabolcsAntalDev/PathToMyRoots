namespace PathToMyRootsApi.Helpers
{
    public static class DateHelper
    {
        //public static DateTime? StringToDateTime(string? dateTime)
        //{
        //    if (string.IsNullOrEmpty(dateTime) || dateTime.Length != 9)
        //        return null;

        //    if (dateTime[0] != '+' ||
        //        !int.TryParse(dateTime.AsSpan(1, 4), out int year) ||
        //        !int.TryParse(dateTime.AsSpan(5, 2), out int month) ||
        //        !int.TryParse(dateTime.AsSpan(7, 2), out int day))
        //    {
        //        return null;
        //    }

        //    try
        //    {
        //        return new DateTime(year, month, day);
        //    }
        //    catch
        //    {
        //        return null;
        //    }
        //}
        //public static string? DateTimeToString(DateTime? dateTime)
        //{
        //    if (dateTime.HasValue)
        //        return $"+{dateTime.Value:yyyyMMdd}";

        //    return null;
        //}
    }
}
