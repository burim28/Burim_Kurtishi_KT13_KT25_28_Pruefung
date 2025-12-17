namespace StundenPlanApp.Models;

public class Schulzimmer
{
    public int Id { get; set; }
    public string Nummer { get; set; } = string.Empty;
    public int Kapazitaet { get; set; }
    
    // Navigation property
    public ICollection<StundenplanEintrag> StundenplanEintraege { get; set; } = new List<StundenplanEintrag>();
}

