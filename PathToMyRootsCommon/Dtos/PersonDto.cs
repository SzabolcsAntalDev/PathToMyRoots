namespace PathToMyRootsCommon.Dtos
{
    public class PersonDto
    {
        public int? Id { get; set; }
        public string? NobleTitle { get; set; }
        public string FirstName { get; set; } = null!;
        public string? LastName { get; set; }
        public string? MaidenName { get; set; }
        public string? OtherNames { get; set; }
        public bool IsMale { get; set; }
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
        public virtual PersonDto? AdoptiveFather { get; set; }
        public virtual PersonDto? AdoptiveMother { get; set; }
        public virtual PersonDto? BiologicalFather { get; set; }
        public virtual PersonDto? BiologicalMother { get; set; }
        public virtual PersonDto? FirstSpouse { get; set; }
        public virtual PersonDto? SecondSpouse { get; set; }
        public virtual List<PersonDto> InverseAdoptiveFather { get; set; } = new List<PersonDto>();
        public virtual List<PersonDto> InverseAdoptiveMother { get; set; } = new List<PersonDto>();
        public virtual List<PersonDto> InverseBiologicalFather { get; set; } = new List<PersonDto>();
        public virtual List<PersonDto> InverseBiologicalMother { get; set; } = new List<PersonDto>();
        public virtual List<PersonDto> InverseFirstSpouse { get; set; } = new List<PersonDto>();
        public virtual List<PersonDto> InverseSecondSpouse { get; set; } = new List<PersonDto>();
    }
}
