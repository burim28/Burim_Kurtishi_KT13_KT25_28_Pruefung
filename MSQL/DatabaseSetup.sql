-- Datenbank für Stundenplan-Applikation BZT Frauenfeld
-- Normalisiert (3. Normalform)

-- Datenbank erstellen
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'StundenplanDB')
BEGIN
    CREATE DATABASE StundenplanDB;
END
GO

USE StundenplanDB;
GO

-- Tabelle für Klassen
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Klassen')
BEGIN
    CREATE TABLE Klassen (
        KlasseId INT PRIMARY KEY IDENTITY(1,1),
        KlasseName NVARCHAR(50) NOT NULL UNIQUE
    );
END
GO

-- Tabelle für Lehrer
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Lehrer')
BEGIN
    CREATE TABLE Lehrer (
        LehrerId INT PRIMARY KEY IDENTITY(1,1),
        LehrerName NVARCHAR(100) NOT NULL
    );
END
GO

-- Tabelle für Schulzimmer
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Schulzimmer')
BEGIN
    CREATE TABLE Schulzimmer (
        SchulzimmerId INT PRIMARY KEY IDENTITY(1,1),
        ZimmerNummer NVARCHAR(50) NOT NULL UNIQUE
    );
END
GO

-- Tabelle für Stundenplaneinträge
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Stundenplaneintraege')
BEGIN
    CREATE TABLE Stundenplaneintraege (
        StundenplanId INT PRIMARY KEY IDENTITY(1,1),
        KlasseId INT NOT NULL,
        Datum DATE NOT NULL,
        Uhrzeit TIME NOT NULL,
        LehrerId INT NOT NULL,
        SchulzimmerId INT NOT NULL,
        FOREIGN KEY (KlasseId) REFERENCES Klassen(KlasseId),
        FOREIGN KEY (LehrerId) REFERENCES Lehrer(LehrerId),
        FOREIGN KEY (SchulzimmerId) REFERENCES Schulzimmer(SchulzimmerId)
    );
END
GO

-- Beispieldaten einfügen
IF NOT EXISTS (SELECT * FROM Klassen)
BEGIN
    INSERT INTO Klassen (KlasseName) VALUES 
        ('INF22'),
        ('INF23'),
        ('INF24');
END
GO

IF NOT EXISTS (SELECT * FROM Lehrer)
BEGIN
    INSERT INTO Lehrer (LehrerName) VALUES 
        ('Hans Müller'),
        ('Anna Schmidt'),
        ('Peter Weber');
END
GO

IF NOT EXISTS (SELECT * FROM Schulzimmer)
BEGIN
    INSERT INTO Schulzimmer (ZimmerNummer) VALUES 
        ('A101'),
        ('A102'),
        ('B201');
END
GO

IF NOT EXISTS (SELECT * FROM Stundenplaneintraege)
BEGIN
    INSERT INTO Stundenplaneintraege (KlasseId, Datum, Uhrzeit, LehrerId, SchulzimmerId) VALUES 
        (1, '2025-01-20', '08:00', 1, 1),
        (1, '2025-01-20', '10:00', 2, 2),
        (2, '2025-01-21', '09:00', 3, 3);
END
GO

