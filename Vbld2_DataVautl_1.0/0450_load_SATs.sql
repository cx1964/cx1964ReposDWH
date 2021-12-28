-- vullen sat S_Medewerker en S_Organisatie_Eenheid

-- Artikel over merge statement
-- https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/


use [TestIntegrationDB2]
go

-- run procedure to load S_Medewerker
exec Load_S_Medewerker2_nvrtrw
go

exec Load_S_Medewerker2_vrtrw
go

-- run procedure to load S_Medewerker
exec TestIntegrationDB2.dbo.Load_S_Organisatie_Eenheid2
go

