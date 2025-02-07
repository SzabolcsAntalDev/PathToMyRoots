using Microsoft.EntityFrameworkCore;

namespace PathToMyRootsDataAccess.Models;

public partial class PathToMyRootsDbContext : DbContext
{
    public PathToMyRootsDbContext()
    {
    }

    public PathToMyRootsDbContext(DbContextOptions<PathToMyRootsDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Person> Persons { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Server=localhost;Database=PathToMyRootsDB;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Person>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Persons__3214EC27DCF2EA6D");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AdoptiveFatherId).HasColumnName("AdoptiveFatherID");
            entity.Property(e => e.AdoptiveMotherId).HasColumnName("AdoptiveMotherID");
            entity.Property(e => e.BiologicalFatherId).HasColumnName("BiologicalFatherID");
            entity.Property(e => e.BiologicalMotherId).HasColumnName("BiologicalMotherID");
            entity.Property(e => e.BirthDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.DeathDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.FirstMarriageEndDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.FirstMarriageStartDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.FirstSpouseId).HasColumnName("FirstSpouseID");
            entity.Property(e => e.ImageUrl).HasMaxLength(110);
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.MaidenName).HasMaxLength(50);
            entity.Property(e => e.NobleTitle).HasMaxLength(50);
            entity.Property(e => e.OtherNames).HasMaxLength(250);
            entity.Property(e => e.SecondMarriageEndDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.SecondMarriageStartDate)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.SecondSpouseId).HasColumnName("SecondSpouseID");

            entity.HasOne(d => d.AdoptiveFather).WithMany(p => p.InverseAdoptiveFather)
                .HasForeignKey(d => d.AdoptiveFatherId)
                .HasConstraintName("FK__Persons__Adoptiv__45F365D3");

            entity.HasOne(d => d.AdoptiveMother).WithMany(p => p.InverseAdoptiveMother)
                .HasForeignKey(d => d.AdoptiveMotherId)
                .HasConstraintName("FK__Persons__Adoptiv__46E78A0C");

            entity.HasOne(d => d.BiologicalFather).WithMany(p => p.InverseBiologicalFather)
                .HasForeignKey(d => d.BiologicalFatherId)
                .HasConstraintName("FK__Persons__Biologi__440B1D61");

            entity.HasOne(d => d.BiologicalMother).WithMany(p => p.InverseBiologicalMother)
                .HasForeignKey(d => d.BiologicalMotherId)
                .HasConstraintName("FK__Persons__Biologi__44FF419A");

            entity.HasOne(d => d.FirstSpouse).WithMany(p => p.InverseFirstSpouse)
                .HasForeignKey(d => d.FirstSpouseId)
                .HasConstraintName("FK__Persons__FirstSp__47DBAE45");

            entity.HasOne(d => d.SecondSpouse).WithMany(p => p.InverseSecondSpouse)
                .HasForeignKey(d => d.SecondSpouseId)
                .HasConstraintName("FK__Persons__SecondS__48CFD27E");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
