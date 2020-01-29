-- Vul de DIMs met de speciale records.
-- De speciale records onstaan, dat men alle velden van de FACTs uit verplichte velden (dus zonder NULL values)
-- wil hebben, omdat NULL values niet goed samengaan met indexen.
-- Daarom heeft men een speciale of meerdere speciale waarden nodig om aan te gegeven,
-- dat iets geen waarde heeft.
-- Aangezien de NULL value voor meerdere betekenissen wordt gebruikt, namelijk:
--    1. onbekend
--    2. geen waarde
--    enz.
--  
-- De waarden en het aantal records voor de speciale gevallen zijn niet standaard
-- Hierin kan men zelf keuzes maken.

-- Ik gebruik de methode van oude DWH
-- -1 = Niet gevonden
-- -2 = Onbekend

use [TestPresentationDB]
go

SET IDENTITY_INSERT dbo.Dim_Organisatie_Eenheid ON;  
go 
insert into Dim_Organisatie_Eenheid (organisatie_eenheid_key,code,naam,meta_record_source,meta_load_date,meta_create_time) values (-1, 'Niet gevonden', NULL, 'system', convert(date, getdate()) , convert(time, getdate()));
insert into Dim_Organisatie_Eenheid (organisatie_eenheid_key,code,naam,meta_record_source,meta_load_date,meta_create_time) values (-2, 'Onbekend', NULL, 'system', convert(date, getdate()) , convert(time, getdate()));
go
SET IDENTITY_INSERT dbo.Dim_Organisatie_Eenheid OFF;  
go  


SET IDENTITY_INSERT dbo.Dim_Medewerker ON;  
go  
insert into Dim_Medewerker (medewerker_key,nr,voorletters,voorvoegsel,achternaam,geboortedatum,aow_datum,meta_record_source,meta_load_date,meta_create_time) values (-1,'??????',NULL,NULL,'Niet gevonden','99991231','99991231','system', convert(date, getdate()) , convert(time, getdate()));
insert into Dim_Medewerker (medewerker_key,nr,voorletters,voorvoegsel,achternaam,geboortedatum,aow_datum,meta_record_source,meta_load_date,meta_create_time) values (-2,'??????',NULL,NULL,'Onbekend','99991231','99991231','system', convert(date, getdate()) , convert(time, getdate()));
go
SET IDENTITY_INSERT dbo.Dim_Medewerker OFF;  
go  
