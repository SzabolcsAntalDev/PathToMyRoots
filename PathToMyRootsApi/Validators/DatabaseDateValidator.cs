using PathToMyRootsSharedModels.Utils;

namespace PathToMyRootsApi.Validators
{
    public static class DatabaseDateValidator
    {
        public static bool IsValid(string? databaseDate)
        {
            string? serverDate;
            try
            {
                serverDate = DateHelper.ConvertDatabaseDateToServerDate(databaseDate);
            }
            catch
            {
                return false;
            }

            return DateHelper.GetServerDateValidationErrorMessage(serverDate) == null;
        }
    }
}
