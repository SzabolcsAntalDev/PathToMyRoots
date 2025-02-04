namespace PathToMyRootsDataAccess.Models;

public partial class Person
{
    public int Id { get; set; }
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
    public virtual Person? AdoptiveFather { get; set; }
    public virtual Person? AdoptiveMother { get; set; }
    public virtual Person? BiologicalFather { get; set; }
    public virtual Person? BiologicalMother { get; set; }
    public virtual Person? FirstSpouse { get; set; }
    public virtual Person? SecondSpouse { get; set; }
    public virtual ICollection<Person> InverseAdoptiveFather { get; set; } = new List<Person>();
    public virtual ICollection<Person> InverseAdoptiveMother { get; set; } = new List<Person>();
    public virtual ICollection<Person> InverseBiologicalFather { get; set; } = new List<Person>();
    public virtual ICollection<Person> InverseBiologicalMother { get; set; } = new List<Person>();
    public virtual ICollection<Person> InverseFirstSpouse { get; set; } = new List<Person>();
    public virtual ICollection<Person> InverseSecondSpouse { get; set; } = new List<Person>();
}
