using Microsoft.EntityFrameworkCore;

namespace PathToMyRootsDataAccess.Models;

public partial class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Person> Persons { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Person>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Persons__3214EC274F69D53F");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.BiologicalFatherId).HasColumnName("BiologicalFatherID");
            entity.Property(e => e.BiologicalMotherId).HasColumnName("BiologicalMotherID");
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.MaidenName).HasMaxLength(50);
            entity.Property(e => e.OtherNames).HasMaxLength(250);
            entity.Property(e => e.SpouseId).HasColumnName("SpouseID");

            // Change the column type to CHAR(9) for BirthDate and DeathDate
            entity.Property(e => e.BirthDate)
                .HasColumnType("CHAR(9)")  // Use CHAR(9) for storing date strings like "+20220520"
                .HasColumnName("BirthDate");

            entity.Property(e => e.DeathDate)
                .HasColumnType("CHAR(9)")  // Use CHAR(9) for storing date strings like "+20220520"
                .HasColumnName("DeathDate");

            entity.HasOne(d => d.BiologicalFather).WithMany(p => p.InverseBiologicalFather)
                .HasForeignKey(d => d.BiologicalFatherId)
                .HasConstraintName("FK__Persons__Biologi__25869641");

            entity.HasOne(d => d.BiologicalMother).WithMany(p => p.InverseBiologicalMother)
                .HasForeignKey(d => d.BiologicalMotherId)
                .HasConstraintName("FK__Persons__Biologi__24927208");

            entity.HasOne(d => d.Spouse).WithMany(p => p.InverseSpouse)
                .HasForeignKey(d => d.SpouseId)
                .HasConstraintName("FK__Persons__SpouseI__267ABA7A");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
