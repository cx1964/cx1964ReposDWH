-- File: 0311_patch01_tbv_toevoegen__meta_change_hashkey_in_SAT_tables3.sql
-- Opmerking: Dit script is bedoelt om de situatie te bereiken zoals in script 0310_create_sat_tables3.sql
--            is beschreven waarbij de SAT tabellen een kolom meta_change_hashkey hebben.
--            Dit script zorgt ervoor dat het script 0310_create_sat_tables3.sql niet nog een keer gedraait hoeft te worden
--            waardoor wordt voorkomen dat de SAT tabellen leeg gegooid worden.


use [TestIntegrationDB3]
go

-- alter tables

-- *** Begin Organisatie_Eenheid2 *** --
alter table [TestIntegrationDB3].[dbo].[S_Organisatie_Eenheid3]
  add meta_change_hashkey [varchar](32) NULL;
GO


-- *** Begin Medewerker *** --

-- 2 SATs voor medewerker: Vertrouwelijk (vrtrw) en niet_vertrouwelijk (nvrtrw)
alter table [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw]
  add meta_change_hashkey [varchar](32) NULL;
GO

alter table [TestIntegrationDB3].[dbo].[S_Medewerker3_nvrtrw]
  add meta_change_hashkey [varchar](32) NULL;
GO

-- vul de meta_change_hashkey kolommen
-- S_Organisatie_Eenheid3
-- Dit ook nog toevoegen aan de laadscripts van de SATs
update [TestIntegrationDB3].[dbo].[S_Organisatie_Eenheid3]
set meta_change_hashkey = HASHBYTES('SHA2_256', S_Organisatie_Eenheid3.[Naam]);
go

-- check
select [Naam],[meta_change_hashkey]
from [dbo].[S_Organisatie_Eenheid3];
go


-- S_Medewerker3_vrtrw
-- letop een NULL value in de concatenatie van kolommen zorgt voor een NULl value als hash waarde
-- daarom wordt een NULL value gemapped naar een '' (lege string).
update [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw]
set meta_change_hashkey = HASHBYTES('SHA2_256', case when S_Medewerker3_vrtrw.voorletters is NULL then '' else S_Medewerker3_vrtrw.voorletters end 
											   +case when S_Medewerker3_vrtrw.voorvoegsel is NULL then '' else S_Medewerker3_vrtrw.voorvoegsel end
											   +case when S_Medewerker3_vrtrw.achternaam  is NULL then '' else S_Medewerker3_vrtrw.achternaam  end
											   +convert(varchar(10),S_Medewerker3_vrtrw.geboortedatum)
											   +convert(varchar(10),S_Medewerker3_vrtrw.aow_datum)
						 );
go

-- check
select 
        S_Medewerker3_vrtrw.voorletters
       ,S_Medewerker3_vrtrw.voorvoegsel
	   ,S_Medewerker3_vrtrw.achternaam
	   ,convert(varchar(10),S_Medewerker3_vrtrw.geboortedatum) as geboortedatum
	   ,convert(varchar(10),S_Medewerker3_vrtrw.aow_datum)     as aow_datum
       ,S_Medewerker3_vrtrw.geboortedatum,[meta_change_hashkey]
from [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw];
go


-- S_Medewerker3_nvrtrw
-- letop een NULL value in de concatenatie van kolommen zorgt voor een NULl value als hash waarde
-- daarom wordt een NULL value gemapped naar een '' (lege string).
update [TestIntegrationDB3].[dbo].[S_Medewerker3_nvrtrw]
set meta_change_hashkey = HASHBYTES('SHA2_256', case when S_Medewerker3_nvrtrw.hoogste_opleiding is NULL then '' else S_Medewerker3_nvrtrw.hoogste_opleiding end 
											   +case when S_Medewerker3_nvrtrw.bril_dragend      is NULL then '' else S_Medewerker3_nvrtrw.bril_dragend      end
											   +convert(varchar(2),S_Medewerker3_nvrtrw.schoenmaat)
						 );
go

-- check
-- letop een NULL value in de concatenatie van kolommen zorgt voor een NULl value als hash waarde
-- daarom wordt een NULL value gemapped naar een '' (lege string).
select 
        case when S_Medewerker3_nvrtrw.hoogste_opleiding is NULL then '' else S_Medewerker3_nvrtrw.hoogste_opleiding end 
	   +case when S_Medewerker3_nvrtrw.bril_dragend      is NULL then '' else S_Medewerker3_nvrtrw.bril_dragend      end
	   +convert(varchar(2),S_Medewerker3_nvrtrw.schoenmaat)
       ,[meta_change_hashkey]
from [TestIntegrationDB3].[dbo].[S_Medewerker3_nvrtrw];
go


