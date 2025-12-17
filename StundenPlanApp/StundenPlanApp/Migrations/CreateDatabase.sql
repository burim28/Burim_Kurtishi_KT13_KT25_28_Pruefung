-- ========================================
-- Stundenplan-Applikation - Datenbank Erstellung
-- ========================================
-- Hinweis: Führen Sie dieses Skript aus, falls die automatischen 
-- Migrationen nicht funktionieren

USE master;
GO

-- Datenbank erstellen (falls nicht vorhanden)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'StundenplanDb')
BEGIN
    CREATE DATABASE StundenplanDb;
END
GO

USE StundenplanDb;
GO

-- Migrations History Tabelle
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

-- ========================================
-- Tabelle: Klassen
-- ========================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Klassen]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Klassen] (
        [Id] int IDENTITY(1,1) NOT NULL,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Klassen] PRIMARY KEY ([Id])
    );
END;
GO

-- ========================================
-- Tabelle: Lehrer
-- ========================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lehrer]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Lehrer] (
        [Id] int IDENTITY(1,1) NOT NULL,
        [Name] nvarchar(100) NOT NULL,
        [Email] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_Lehrer] PRIMARY KEY ([Id])
    );
END;
GO

-- ========================================
-- Tabelle: Schulzimmer
-- ========================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Schulzimmer]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Schulzimmer] (
        [Id] int IDENTITY(1,1) NOT NULL,
        [Nummer] nvarchar(20) NOT NULL,
        [Kapazitaet] int NOT NULL,
        CONSTRAINT [PK_Schulzimmer] PRIMARY KEY ([Id])
    );
END;
GO

-- ========================================
-- Tabelle: StundenplanEintraege
-- ========================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StundenplanEintraege]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[StundenplanEintraege] (
        [Id] int IDENTITY(1,1) NOT NULL,
        [KlasseId] int NOT NULL,
        [LehrerId] int NOT NULL,
        [SchulzimmerId] int NOT NULL,
        [Datum] datetime2 NOT NULL,
        [Uhrzeit] time NOT NULL,
        [Aufgabenstellung] nvarchar(500) NOT NULL,
        CONSTRAINT [PK_StundenplanEintraege] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_StundenplanEintraege_Klassen_KlasseId] 
            FOREIGN KEY ([KlasseId]) REFERENCES [Klassen] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_StundenplanEintraege_Lehrer_LehrerId] 
            FOREIGN KEY ([LehrerId]) REFERENCES [Lehrer] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_StundenplanEintraege_Schulzimmer_SchulzimmerId] 
            FOREIGN KEY ([SchulzimmerId]) REFERENCES [Schulzimmer] ([Id]) ON DELETE NO ACTION
    );
END;
GO

-- ========================================
-- Indizes erstellen
-- ========================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_StundenplanEintraege_KlasseId')
BEGIN
    CREATE INDEX [IX_StundenplanEintraege_KlasseId] 
    ON [StundenplanEintraege] ([KlasseId]);
END;
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_StundenplanEintraege_LehrerId')
BEGIN
    CREATE INDEX [IX_StundenplanEintraege_LehrerId] 
    ON [StundenplanEintraege] ([LehrerId]);
END;
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_StundenplanEintraege_SchulzimmerId')
BEGIN
    CREATE INDEX [IX_StundenplanEintraege_SchulzimmerId] 
    ON [StundenplanEintraege] ([SchulzimmerId]);
END;
GO

-- ========================================
-- Seed-Daten: Klassen
-- ========================================
IF NOT EXISTS (SELECT * FROM Klassen WHERE Id = 1)
BEGIN
    SET IDENTITY_INSERT [Klassen] ON;
    
    INSERT INTO [Klassen] ([Id], [Name]) VALUES (1, N'INF22');
    INSERT INTO [Klassen] ([Id], [Name]) VALUES (2, N'INF23');
    INSERT INTO [Klassen] ([Id], [Name]) VALUES (3, N'ELT22');
    
    SET IDENTITY_INSERT [Klassen] OFF;
END;
GO

-- ========================================
-- Seed-Daten: Lehrer
-- ========================================
IF NOT EXISTS (SELECT * FROM Lehrer WHERE Id = 1)
BEGIN
    SET IDENTITY_INSERT [Lehrer] ON;
    
    INSERT INTO [Lehrer] ([Id], [Name], [Email]) VALUES (1, N'Herr Müller', N'mueller@bzt.ch');
    INSERT INTO [Lehrer] ([Id], [Name], [Email]) VALUES (2, N'Frau Schmidt', N'schmidt@bzt.ch');
    INSERT INTO [Lehrer] ([Id], [Name], [Email]) VALUES (3, N'Herr Weber', N'weber@bzt.ch');
    
    SET IDENTITY_INSERT [Lehrer] OFF;
END;
GO

-- ========================================
-- Seed-Daten: Schulzimmer
-- ========================================
IF NOT EXISTS (SELECT * FROM Schulzimmer WHERE Id = 1)
BEGIN
    SET IDENTITY_INSERT [Schulzimmer] ON;
    
    INSERT INTO [Schulzimmer] ([Id], [Nummer], [Kapazitaet]) VALUES (1, N'A101', 20);
    INSERT INTO [Schulzimmer] ([Id], [Nummer], [Kapazitaet]) VALUES (2, N'B205', 25);
    INSERT INTO [Schulzimmer] ([Id], [Nummer], [Kapazitaet]) VALUES (3, N'C303', 30);
    
    SET IDENTITY_INSERT [Schulzimmer] OFF;
END;
GO

-- ========================================
-- Migration History aktualisieren
-- ========================================
IF NOT EXISTS (SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20251217180857_InitialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20251217180857_InitialCreate', N'10.0.0');
END;
GO

PRINT 'Datenbank erfolgreich erstellt und mit Seed-Daten gefüllt!';
GO

