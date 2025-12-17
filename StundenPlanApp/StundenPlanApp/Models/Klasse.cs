namespace StundenPlanApp.Models;

public class Klasse
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    
    // Navigation property
    public ICollection<StundenplanEintrag> StundenplanEintraege { get; set; } = new List<StundenplanEintrag>();
}

