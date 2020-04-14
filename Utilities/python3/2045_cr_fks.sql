-- filenaam: 2040_cr_fks.sql
-- Functie: toevoegen foreign key definites

use [TestSourceDB3];
go

-- Toevoegen fk definitie
ALTER TABLE [codafin12].[oas_grplis]
   ADD CONSTRAINT FK_oas_grplist_oas_himlist
   FOREIGN KEY
   REFERENCES oas_himlist (
      [cmpcode]
	 ,[code]
     ,[grpcode]
   );

--     himlist.cmpcode = grplist.cmpcode
-- and himlist.grpcode = grplist.grpcode     



-- Toevoegen fk definitie
ALTER TABLE [codafin12].[oas_element]
   ADD CONSTRAINT FK_oas_element_oas_grplist
   FOREIGN KEY
   REFERENCES [codafin12].[oas_grplist] (
      [cmpcode]
	 ,[code]
	 ,[elmlevel]
   );

--     element.cmpcode  = grplist.cmpcode
-- and element.code     = grplist.code
-- and element.elmlevel = grplist.elmlevel







