using PathToMyRootsWebApp.Constants;

namespace PathToMyRootsWebApp.Models
{
    public class PersonModel
    {
        public int? Id { get; set; } = PathToMyRootsWebAppConstants.UnsetIntValue;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? MaidenName { get; set; }

        public string? OtherNames { get; set; }

        public bool IsMale { get; set; }

        public DateTime? BirthDate { get; set; }

        public DateTime? DeathDate { get; set; }

        public int? BiologicalMotherId { get; set; }

        public int? BiologicalFatherId { get; set; }

        public int? SpouseId { get; set; }

        public virtual PersonModel? BiologicalFather { get; set; }

        public virtual PersonModel? BiologicalMother { get; set; }

        public virtual PersonModel? Spouse { get; set; }
    }
}
