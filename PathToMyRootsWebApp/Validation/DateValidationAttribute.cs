using PathToMyRootsSharedModels.Utils;
using System.ComponentModel.DataAnnotations;

namespace PathToMyRootsWebApp.Validation
{
    public class DateValidationAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            var validationErrorMessage = DateHelper.GetServerDateValidationErrorMessage(value as string);

            return validationErrorMessage == null
                ? ValidationResult.Success
                : new ValidationResult(validationErrorMessage);
        }
    }
}
