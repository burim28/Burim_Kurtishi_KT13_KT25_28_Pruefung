# Stundenplan-Applikation für BZT Frauenfeld

## Projektübersicht

Dies ist eine Web-Applikation zur Verwaltung von Stundenplänen für das Bildungszentrum für Technik (BZT) Frauenfeld.
Entwickelt mit **Blazor** (.NET 10) und **MSSQL** Datenbank.

## Funktionen

- ✅ **CRUD-Operationen** für Stundenplaneinträge
- ✅ **Normalisierte Datenbank** (3. Normalform)
- ✅ **Entity Framework Core** mit Database-First Ansatz
- ✅ **Responsive Benutzeroberfläche** mit Bootstrap
- ✅ Verwaltung von **Klassen**, **Lehrern** und **Schulzimmern**

## Datenmodell (3. Normalform)

### Tabellen

1. **Klassen**
   - Id (Primary Key)
   - Name (z.B. "INF22", "INF23", "ELT22")

2. **Lehrer**
   - Id (Primary Key)
   - Name
   - Email

3. **Schulzimmer**
   - Id (Primary Key)
   - Nummer (z.B. "A101", "B205")
   - Kapazität

4. **StundenplanEintraege**
   - Id (Primary Key)
   - KlasseId (Foreign Key → Klassen)
   - LehrerId (Foreign Key → Lehrer)
   - SchulzimmerId (Foreign Key → Schulzimmer)
   - Datum
   - Uhrzeit
   - Aufgabenstellung

## Installation & Setup

### Voraussetzungen

- .NET 10 SDK
- SQL Server / SQL Server Express / LocalDB
- Visual Studio 2025 oder VS Code (optional)

### Datenbank einrichten

#### Option 1: Mit Entity Framework Migrations (empfohlen)

```bash
# Projekt wiederherstellen
dotnet restore

# Datenbank erstellen und Migrationen anwenden
dotnet ef database update
```

#### Option 2: Mit SQL-Skript

Falls die Migrations nicht funktionieren, können Sie das SQL-Skript manuell ausführen:

1. Öffnen Sie SQL Server Management Studio (SSMS)
2. Führen Sie das Skript `Migrations/DatabaseScript.sql` aus

### Connection String anpassen

Öffnen Sie `appsettings.json` und passen Sie die Connection String an:

```json
{
  "ConnectionStrings": {
    "StundenplanDb": "Server=(localdb)\\mssqllocaldb;Database=StundenplanDb;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}
```

**Alternative Connection Strings:**

- LocalDB: `Server=(localdb)\\mssqllocaldb;Database=StundenplanDb;Trusted_Connection=True;TrustServerCertificate=True;`
- SQL Server Express: `Server=localhost\\SQLEXPRESS;Database=StundenplanDb;Trusted_Connection=True;TrustServerCertificate=True;`
- SQL Server mit Authentifizierung: `Server=localhost;Database=StundenplanDb;User Id=sa;Password=YourPassword;TrustServerCertificate=True;`

## Anwendung starten

```bash
# Projekt builden
dotnet build

# Anwendung starten
dotnet run
```

Die Anwendung ist dann erreichbar unter: `https://localhost:5001` oder `http://localhost:5000`

## Navigation

Die Anwendung verfügt über folgende Seiten (sichtbar im NavMenu):

- **Home**: Startseite mit Übersicht
- **Stundenplan**: Liste aller Stundenplaneinträge mit CRUD-Funktionen
- **Klassen**: Verwaltung der Klassen
- **Lehrer**: Verwaltung der Lehrer
- **Schulzimmer**: Verwaltung der Schulzimmer

## Verwendete Technologien

- **Frontend**: Blazor Server (.NET 10)
- **Backend**: ASP.NET Core 10
- **Datenbank**: Microsoft SQL Server
- **ORM**: Entity Framework Core 10
- **UI Framework**: Bootstrap 5

## Projekt-Struktur

```
StundenPlanApp/
├── Components/
│   ├── Layout/          # Layout-Komponenten (NavMenu, MainLayout)
│   └── Pages/           # Razor-Seiten (Stundenplan, Klassen, etc.)
├── Data/
│   └── StundenplanDbContext.cs    # EF Core DbContext
├── Models/
│   ├── Klasse.cs
│   ├── Lehrer.cs
│   ├── Schulzimmer.cs
│   └── StundenplanEintrag.cs
├── Migrations/          # EF Core Migrations
└── wwwroot/             # Statische Dateien (CSS, JS)
```

## Seed-Daten

Die Datenbank wird automatisch mit folgenden Test-Daten gefüllt:

### Klassen
- INF22
- INF23
- ELT22

### Lehrer
- Herr Müller (mueller@bzt.ch)
- Frau Schmidt (schmidt@bzt.ch)
- Herr Weber (weber@bzt.ch)

### Schulzimmer
- A101 (Kapazität: 20)
- B205 (Kapazität: 25)
- C303 (Kapazität: 30)

## Entwickler

Entwickelt für die Prüfung: **Web-Applikation mit Blazor und MSSQL**

**Thema**: Stundenplan-Applikation für das BZT Frauenfeld

## Lizenz

Dieses Projekt wurde für Bildungszwecke erstellt.

