using PathToMyRootsSharedModels.Dtos;
using PathToMyRootsWebApp.Constants;

namespace PathToMyRootsWebApp.Models
{
    public class PersonModel
    {
        public int? Id { get; set; } = PathToMyRootsWebAppConstants.UnsetIntValue;
        public string? NobleTitle { get; set; }
        public string FirstName { get; set; } = null!;
        public string? LastName { get; set; }
        public string? MaidenName { get; set; }
        public string? OtherNames { get; set; }
        public bool IsMale { get; set; } = true;
        public string? BirthDate { get; set; }
        public string? DeathDate { get; set; }
        public int? BiologicalFatherId { get; set; }
        public int? BiologicalMotherId { get; set; }
        public int? AdoptiveFatherId { get; set; }
        public int? AdoptiveMotherId { get; set; }
        public int? FirstSpouseId { get; set; }
        public int? SecondSpouseId { get; set; }
        public string? FirstMarriageStartDate { get; set; }
        public string? FirstMarriageEndDate { get; set; }
        public string? SecondMarriageStartDate { get; set; }
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
