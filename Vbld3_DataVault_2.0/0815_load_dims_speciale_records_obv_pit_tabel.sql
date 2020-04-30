-- File: 0815_load_dims_speciale_records_obv_pit_tabel.sql.sql

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

use [TestPresentationDB3]
go

-- verwijder FK tussen FACT en DIM tbv laden
ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet]
DROP CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Compleet_Dim_Organisatie_Eenheid_Compleet];
GO

truncate table Dim_Medewerker_Compleet;
--truncate table Dim_Organisatie_Eenheid_?;
go


--insert into Dim_Organisatie_?
--(H_Organisatie3HashKey,meta_load_date,meta_create_time,code,naam,meta_record_source)
--values
--('-1','99991231','00:00:00','Niet gevonden', NULL, 'system');

--insert into Dim_Organisatie_Eenheid_?
--(H_Organisatie3HashKey,meta_load_date,meta_create_time,code,naam,meta_record_source)
--values
--('-2','99991231','00:00:00','Onbekend', NULL, 'system');
--go  
-- to hier ok


insert into Dim_Medewerker_Pit
([H_Medewerker3Hashkey],[meta_load_date],[meta_create_time],[nr],[hoogste_opleiding],[bril_dragend],[schoenmaat],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[meta_record_source])
values
 ('-1','99991231','00:00:00','-1', '?', '?', 0, '?', '?', '?', '99991231', '99991231', 'system');


insert into Dim_Medewerker_Pit
([H_Medewerker3Hashkey],[meta_load_date],[meta_create_time],[nr],[hoogste_opleiding],[bril_dragend],[schoenmaat],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[meta_record_source])
values
 ('-2','99991231','00:00:00','-1', '?', '?', 0, '?', '?', '?', '99991231', '99991231', 'system');
