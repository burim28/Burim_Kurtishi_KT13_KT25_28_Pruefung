-- ========================================
-- Stundenplan-Applikation - Datenbank Verifizierung
-- ========================================

-- 1. Datenbank wechseln
USE StundenplanDb;
GO

-- 2. Alle Tabellen anzeigen
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

-- 3. Struktur der Klassen-Tabelle prüfen
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Klassen'
ORDER BY ORDINAL_POSITION;
GO

-- 4. Struktur der Lehrer-Tabelle prüfen
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Lehrer'
ORDER BY ORDINAL_POSITION;
GO

-- 5. Struktur der Schulzimmer-Tabelle prüfen
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Schulzimmer'
ORDER BY ORDINAL_POSITION;
GO

-- 6. Struktur der StundenplanEintraege-Tabelle prüfen
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StundenplanEintraege'
ORDER BY ORDINAL_POSITION;
GO

-- 7. Alle Foreign Key Constraints anzeigen
SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
WHERE tp.name IN ('Klassen', 'Lehrer', 'Schulzimmer', 'StundenplanEintraege')
ORDER BY ParentTable, ForeignKeyName;
GO

-- 8. Seed-Daten überprüfen

-- Klassen
SELECT * FROM Klassen;
GO

-- Lehrer
SELECT * FROM Lehrer;
GO

-- Schulzimmer
SELECT * FROM Schulzimmer;
GO

-- Stundenplaneinträge (sollte am Anfang leer sein)
SELECT * FROM StundenplanEintraege;
GO

-- 9. Beispiel-Abfrage: Alle Stundenplaneinträge mit JOIN
SELECT 
    s.Id,
    k.Name AS Klasse,
    s.Datum,
    s.Uhrzeit,
    l.Name AS Lehrer,
    sz.Nummer AS Schulzimmer,
    sz.Kapazitaet,
    s.Aufgabenstellung
FROM StundenplanEintraege s
INNER JOIN Klassen k ON s.KlasseId = k.Id
INNER JOIN Lehrer l ON s.LehrerId = l.Id
INNER JOIN Schulzimmer sz ON s.SchulzimmerId = sz.Id
ORDER BY s.Datum, s.Uhrzeit;
GO

-- 10. Statistiken
SELECT 
    'Klassen' AS Tabelle, 
    COUNT(*) AS Anzahl 
FROM Klassen
UNION ALL
SELECT 
    'Lehrer' AS Tabelle, 
    COUNT(*) AS Anzahl 
FROM Lehrer
UNION ALL
SELECT 
    'Schulzimmer' AS Tabelle, 
    COUNT(*) AS Anzahl 
FROM Schulzimmer
UNION ALL
SELECT 
    'StundenplanEintraege' AS Tabelle, 
    COUNT(*) AS Anzahl 
FROM StundenplanEintraege;
GO

