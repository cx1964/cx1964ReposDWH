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

-- verplicht maken van de pk columns
ALTER TABLE [codafin12].[oas_grplist]
  ALTER COLUMN [cmpcode] varchar(12) NOT NULL;

ALTER TABLE [codafin12].[oas_grplist]
  ALTER COLUMN [code] varchar(72) NOT NULL;  

ALTER TABLE [codafin12].[oas_grplist]
  ALTER COLUMN [elmlevel] smallint NOT NULL;  

ALTER TABLE [codafin12].[oas_grplist]
  ALTER COLUMN [lstseqno] smallint NOT NULL;  

--ALTER TABLE [codafin12].[oas_grplist]
--  drop CONSTRAINT PK_oas_grplist;

-- Toevoegen pk definitie
ALTER TABLE [codafin12].[oas_grplist]
   ADD CONSTRAINT PK_oas_grplist
   PRIMARY KEY CLUSTERED (
	 [cmpcode]
	,[code]
	,[elmlevel]
	,[lstseqno]
   );

--select
--   [cmpcode]
--	,[code]
--	,[elmlevel]
--from [codafin12].[oas_grplist]
--group by
-- 	 [cmpcode]
--	,[code]
--	,[elmlevel]
--	,[lstseqno]
--having count(*) > 1


-- verplicht maken van de pk columns
ALTER TABLE [codafin12].[oas_himlist]
  -- ALTER COLUMN [code] varchar(12) NOT NULL; 
  ALTER COLUMN [code] varchar(72) NOT NULL;  

ALTER TABLE [codafin12].[oas_himlist]
  -- ALTER COLUMN [lstseqno] int NOT NULL;  
  ALTER COLUMN [lstseqno] smallint NOT NULL;  

ALTER TABLE [codafin12].[oas_himlist]
   drop CONSTRAINT PK_oas_himlist;

-- Toevoegen pk definitie
ALTER TABLE [codafin12].[oas_himlist]
   ADD CONSTRAINT PK_oas_himlist
   PRIMARY KEY CLUSTERED (
	 [code]
	,[lstseqno]
   );
