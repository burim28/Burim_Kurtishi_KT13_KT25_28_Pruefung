namespace StundenPlanApp.Models;

public class StundenplanEintrag
{
    public int Id { get; set; }
    
    // Foreign Keys
    public int KlasseId { get; set; }
    public int LehrerId { get; set; }
    public int SchulzimmerId { get; set; }
    
    // Weitere Eigenschaften
    public DateTime Datum { get; set; }
    public TimeSpan Uhrzeit { get; set; }
    public string Aufgabenstellung { get; set; } = string.Empty;
    
    // Navigation properties
    public Klasse? Klasse { get; set; }
    public Lehrer? Lehrer { get; set; }
    public Schulzimmer? Schulzimmer { get; set; }
}

