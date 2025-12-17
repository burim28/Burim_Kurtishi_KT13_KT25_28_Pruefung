using Microsoft.EntityFrameworkCore;
using StundenPlanApp.Models;

namespace StundenPlanApp.Data;

public class StundenplanDbContext : DbContext
{
    public StundenplanDbContext(DbContextOptions<StundenplanDbContext> options)
        : base(options)
    {
    }

    public DbSet<Klasse> Klassen { get; set; }
    public DbSet<Lehrer> Lehrer { get; set; }
    public DbSet<Schulzimmer> Schulzimmer { get; set; }
    public DbSet<StundenplanEintrag> StundenplanEintraege { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Klasse Konfiguration
        modelBuilder.Entity<Klasse>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired().HasMaxLength(50);
        });

        // Lehrer Konfiguration
        modelBuilder.Entity<Lehrer>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Email).HasMaxLength(100);
        });

        // Schulzimmer Konfiguration
        modelBuilder.Entity<Schulzimmer>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nummer).IsRequired().HasMaxLength(20);
        });

        // StundenplanEintrag Konfiguration
        modelBuilder.Entity<StundenplanEintrag>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Aufgabenstellung).HasMaxLength(500);

            // Foreign Key Beziehungen
            entity.HasOne(e => e.Klasse)
                .WithMany(k => k.StundenplanEintraege)
                .HasForeignKey(e => e.KlasseId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Lehrer)
                .WithMany(l => l.StundenplanEintraege)
                .HasForeignKey(e => e.LehrerId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Schulzimmer)
                .WithMany(s => s.StundenplanEintraege)
                .HasForeignKey(e => e.SchulzimmerId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // Seed Daten
        modelBuilder.Entity<Klasse>().HasData(
            new Klasse { Id = 1, Name = "INF22" },
            new Klasse { Id = 2, Name = "INF23" },
            new Klasse { Id = 3, Name = "ELT22" }
        );

        modelBuilder.Entity<Lehrer>().HasData(
            new Lehrer { Id = 1, Name = "Herr Müller", Email = "mueller@bzt.ch" },
            new Lehrer { Id = 2, Name = "Frau Schmidt", Email = "schmidt@bzt.ch" },
            new Lehrer { Id = 3, Name = "Herr Weber", Email = "weber@bzt.ch" }
        );

        modelBuilder.Entity<Schulzimmer>().HasData(
            new Schulzimmer { Id = 1, Nummer = "A101", Kapazitaet = 20 },
            new Schulzimmer { Id = 2, Nummer = "B205", Kapazitaet = 25 },
            new Schulzimmer { Id = 3, Nummer = "C303", Kapazitaet = 30 }
        );
    }
}

