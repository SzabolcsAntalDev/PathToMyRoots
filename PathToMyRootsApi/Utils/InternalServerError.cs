using Microsoft.AspNetCore.Mvc;
using PathToMyRootsCommon.Enums;

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
