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
        public bool IsMale { get; set; }
        public string? BirthDate { get; set; }
        public string? DeathDate { get; set; }
        public int? BiologicalMotherId { get; set; }
        public int? BiologicalFatherId { get; set; }
        public int? SpouseId { get; set; }
        public virtual PersonModel? BiologicalFather { get; set; }
        public virtual PersonModel? BiologicalMother { get; set; }
        public virtual PersonModel? Spouse { get; set; }
        public string? ImageUrl { get; set; }
    }
}
