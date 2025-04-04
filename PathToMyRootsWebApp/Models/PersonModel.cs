using PathToMyRootsWebApp.Constants;
using PathToMyRootsWebApp.Validation;
using System.ComponentModel.DataAnnotations;

namespace PathToMyRootsWebApp.Models
{
    public class PersonModel
    {
        private const int NamesMaxNumberOfCharacters = 50;
        private const int OhterNamesMaxNumberOfCharacters = 250;

        public int? Id { get; set; } = PathToMyRootsWebAppConstants.UnsetIntValue;

        [StringLength(NamesMaxNumberOfCharacters, ErrorMessage = "Noble Title must be maximum 50 characters long.")]
        public string? NobleTitle { get; set; }

        [Required(ErrorMessage = "First Name is required.")]
        [StringLength(NamesMaxNumberOfCharacters, ErrorMessage = "First Name must be maximum 50 characters long.")]
        public string FirstName { get; set; } = null!;

        [StringLength(NamesMaxNumberOfCharacters, ErrorMessage = "Last Name must be maximum 50 characters long.")]
        public string? LastName { get; set; }

        [StringLength(NamesMaxNumberOfCharacters, ErrorMessage = "Maiden Name must be maximum 50 characters long.")]
        public string? MaidenName { get; set; }

        [StringLength(OhterNamesMaxNumberOfCharacters, ErrorMessage = "Other Names must be maximum 250 characters long.")]
        public string? OtherNames { get; set; }

        public bool IsMale { get; set; } = true;

        [DateValidation]
        public string? BirthDate { get; set; }

        [DateValidation]
        public string? DeathDate { get; set; }

        [RelativesValidation]
        public int? BiologicalFatherId { get; set; }

        [RelativesValidation]
        public int? BiologicalMotherId { get; set; }

        [RelativesValidation]
        public int? AdoptiveFatherId { get; set; }

        [RelativesValidation]
        public int? AdoptiveMotherId { get; set; }

        [RelativesValidation]
        public int? FirstSpouseId { get; set; }

        [RelativesValidation]
        public int? SecondSpouseId { get; set; }

        [DateValidation]
        public string? FirstMarriageStartDate { get; set; }

        [DateValidation]
        public string? FirstMarriageEndDate { get; set; }

        [DateValidation]
        public string? SecondMarriageStartDate { get; set; }

        [DateValidation]
        public string? SecondMarriageEndDate { get; set; }

        public string? ImageUrl { get; set; }
        public virtual PersonModel? AdoptiveFather { get; set; }
        public virtual PersonModel? AdoptiveMother { get; set; }
        public virtual PersonModel? BiologicalFather { get; set; }
        public virtual PersonModel? BiologicalMother { get; set; }
        public virtual PersonModel? FirstSpouse { get; set; }
        public virtual PersonModel? SecondSpouse { get; set; }
    }
}
