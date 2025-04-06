using PathToMyRootsSharedModels.Enums;

namespace PathToMyRootsWebApp.Models
{
    public class PersonResult
    {
        public PersonModel PersonModel { get; }
        public ErrorCode ErrorCode { get; } = ErrorCode.NoError;
        public bool IsValid => ErrorCode == ErrorCode.NoError;

        public PersonResult(PersonModel personModel, string errorCodeString)
        {
            PersonModel = personModel;
            ErrorCode = ErrorCodeStringToErrorCode(errorCodeString);
        }

        public PersonResult(PersonModel personModel)
        {
            PersonModel = personModel;
        }

        public PersonResult(string errorCodeString)
        {
            PersonModel = new PersonModel();
            ErrorCode = ErrorCodeStringToErrorCode(errorCodeString);
        }

        private static ErrorCode ErrorCodeStringToErrorCode(string errorCodeString)
        {
            return
                Enum.TryParse<ErrorCode>(errorCodeString, out var errorCode)
                    ? errorCode
                    : ErrorCode.UnknownError;
        }
    }
}
