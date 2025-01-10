namespace PathToMyRootsSharedModels.Dtos
{
    public class PersonDto
    {
        public int? Id { get; set; }
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
        public PersonDto? BiologicalFather { get; set; }
        public PersonDto? BiologicalMother { get; set; }
        public PersonDto? Spouse { get; set; }
        public List<PersonDto> InverseBiologicalMother { get; set; } = new();
        public List<PersonDto> InverseBiologicalFather { get; set; } = new();
    }
}
