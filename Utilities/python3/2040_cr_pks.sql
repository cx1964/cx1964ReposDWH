-- filenaam: 2040_cr_pks.sql
-- Functie: toevoegen primairy key definites obv clustered index definities in de oorspronkelijke bron

use [TestSourceDB3];
go

-- verplicht maken van de pk columns
ALTER TABLE [codafin12].[oas_element]
  ALTER COLUMN [cmpcode] varchar(12) NOT NULL;

ALTER TABLE [codafin12].[oas_element]
  ALTER COLUMN [code] varchar(72) NOT NULL;

ALTER TABLE [codafin12].[oas_element]
  ALTER COLUMN [elmlevel] smallint NOT NULL;

-- Toevoegen pk definitie
ALTER TABLE [codafin12].[oas_element]
   ADD CONSTRAINT PK_oas_element
   PRIMARY KEY CLUSTERED (
     [cmpcode]
	,[code]
	,[elmlevel]
   );


-- ToDo afmaken:
-- 1. verplicht not null constraints resterende tabellen
-- 2. pk definities resterende tabellen

-- [codafin12].[oas_grplist]
[dbo].[oas_grplist]
(
	 [cmpcode]
	,[code]
	,[elmlevel]
	,[lstseqno]
)



-- [codafin12].[oas_himlist]
[dbo].[oas_himlist]
(
	[code]
	,[lstseqno]
)


