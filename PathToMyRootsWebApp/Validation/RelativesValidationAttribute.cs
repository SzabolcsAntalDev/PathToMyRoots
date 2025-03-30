using PathToMyRootsWebApp.Models;
using System.ComponentModel.DataAnnotations;

namespace PathToMyRootsWebApp.Validation
{
    public class RelativesValidationAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value == null)
                return ValidationResult.Success;

            if (!int.TryParse(value.ToString(), out int relativeId))
                return new ValidationResult("The id of the person is not in a correct format.");

            var personModel = (PersonModel)validationContext.ObjectInstance;
            var relativeIds = new List<int?>()
            {
                personModel.BiologicalFatherId,
                personModel.BiologicalMotherId,
                personModel.AdoptiveFatherId,
                personModel.AdoptiveMotherId,
                personModel.FirstSpouseId,
                personModel.SecondSpouseId
            };

            return relativeIds.Where(id => id == relativeId).Count() < 2
                ? ValidationResult.Success
                : new ValidationResult("A person cannot be assigned multiple roles as a relative.");
        }
    }
}
