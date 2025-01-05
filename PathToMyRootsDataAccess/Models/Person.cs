using System;
using System.Collections.Generic;

namespace PathToMyRootsDataAccess.Models;

public partial class Person
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string? MaidenName { get; set; }

    public string? OtherNames { get; set; }

    public bool IsMale { get; set; }

    public DateOnly? BirthDate { get; set; }

    public DateOnly? DeathDate { get; set; }

    public int? BiologicalMotherId { get; set; }

    public int? BiologicalFatherId { get; set; }

    public int? SpouseId { get; set; }

    public virtual Person? BiologicalFather { get; set; }

    public virtual Person? BiologicalMother { get; set; }

    public virtual ICollection<Person> InverseBiologicalFather { get; set; } = new List<Person>();

    public virtual ICollection<Person> InverseBiologicalMother { get; set; } = new List<Person>();

    public virtual ICollection<Person> InverseSpouse { get; set; } = new List<Person>();

    public virtual Person? Spouse { get; set; }
}
