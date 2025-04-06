using Microsoft.AspNetCore.Mvc;
using PathToMyRootsSharedModels.Enums;

namespace PathToMyRootsApi.Utils
{
    public class InternalServerError : ObjectResult
    {
        public InternalServerError(ErrorCode errorCode)
            : base(errorCode)
        {
            StatusCode = 500;
        }
    }
}
