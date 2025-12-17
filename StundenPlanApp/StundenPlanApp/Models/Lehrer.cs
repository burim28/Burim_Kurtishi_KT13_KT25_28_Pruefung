namespace StundenPlanApp.Models;

public class Lehrer
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    
    // Navigation property
    public ICollection<StundenplanEintrag> StundenplanEintraege { get; set; } = new List<StundenplanEintrag>();
}

