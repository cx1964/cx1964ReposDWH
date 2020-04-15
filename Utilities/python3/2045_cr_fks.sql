-- filenaam: 2040_cr_fks.sql
-- Functie: toevoegen foreign key definites

use [TestSourceDB3];
go

-- Toevoegen fk definitie
--ALTER TABLE [codafin12].[oas_grplist]
--   ADD CONSTRAINT FK_oas_grplist_oas_himlist
--   FOREIGN KEY (
--	 [code]
--	,[lstseqno]
--   )
--   REFERENCES [codafin12].[oas_himlist] (
--	 [code]
--	,[lstseqno]
--  );

-- *** find orphaned records ***
-- De foreign key tabel
SELECT *
FROM [codafin12].[oas_grplist] grplist
WHERE NOT EXISTS
(
    -- de primairy key tabel
    SELECT 'dummy' 
    FROM[codafin12].[oas_himlist] himlist
    WHERE 1=1 
	  and himlist.[code] = grplist.[code]
	  and himlist.[lstseqno] = grplist.[lstseqno]
)
-- Dit levert records op, daaror is het niet mogelijk een fk te maken op tabel  oas_grplist die verwijst naar oas_himlist


--ALTER TABLE [codafin12].[oas_himlist]
--   ADD CONSTRAINT FK_oas_himlist_oas_grplist
--   FOREIGN KEY (
--     [cmpcode]
--	,[code]
--    ,[elmlevel]
--	,[lstseqno]
--   )
--   REFERENCES [codafin12].[oas_grplist] (
--     [cmpcode]
--	,[code]
--    ,[elmlevel]
--	,[lstseqno]
--  );

-- *** find orphaned records ***
-- De foreign key tabel
SELECT *
FROM [codafin12].[oas_himlist] himlist
WHERE NOT EXISTS
(
    -- de primairy key tabel
    SELECT 'dummy' 
    FROM [codafin12].[oas_grplist] grplist
    WHERE 1=1 
	  and [cmpcode] = himlist.[cmpcode]
	  and grplist.[code] = himlist.[code] 
      and [elmlevel] = himlist.[elmlevel]
	  and grplist.[lstseqno] = himlist.[lstseqno] 
)
-- Dit levert records op, daaror is het niet mogelijk een fk te maken op tabel oas_himlist die verwijst naar oas_grplist


-- Toevoegen fk definitie
ALTER TABLE [codafin12].[oas_element]
   ADD CONSTRAINT FK_oas_element_oas_grplist
   FOREIGN KEY
   REFERENCES [codafin12].[oas_grplist] (
      [cmpcode]
	 ,[code]
	 ,[elmlevel]
   );

-- *** find orphaned records ***
-- De foreign key tabel
SELECT *
FROM [codafin12].[oas_element] element
WHERE NOT EXISTS
(
    -- de primairy key tabel
    SELECT 'dummy' 
    FROM [codafin12].[oas_grplist] grplist
    WHERE 1=1 
	  and grplist.[cmpcode] = element.[cmpcode]
	  and grplist.[code] = element.[code]
      and grplist.[elmlevel] = element.[elmlevel]
)
-- Dit levert records op, daaror is het niet mogelijk een fk te maken op tabel oas_element die verwijst naar oas_grplist


-- *** find orphaned records ***
-- De foreign key tabel
SELECT *
FROM [codafin12].[oas_grplist] grplist
WHERE NOT EXISTS
(
    -- de primairy key tabel
    SELECT 'dummy' 
    FROM [codafin12].[oas_element] element
    WHERE 1=1 
	  and element.[cmpcode] = grplist.[cmpcode]
	  and element.[code] = grplist.[code]
      and element.[elmlevel] = grplist.[elmlevel]
)
-- Dit levert records op, daaror is het niet mogelijk een fk te maken op tabel oas_grplist die verwijst naar oas_element

-- Conclusie men kan niet fk op de databases definieren die actief door de database worden bewaakt

