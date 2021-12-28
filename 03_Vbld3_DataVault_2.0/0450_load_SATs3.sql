-- File: 0450_load_SATs3.sql
-- Functie: Vullen sat S_Medewerker en S_Organisatie_Eenheid
--          obv DataVault 2.0, dwz alleen SAT inserten en geen update en zonder end dating 

use [TestIntegrationDB3]
go

-- load S_Medewerker3_nvrtrw
insert into [TestIntegrationDB3].dbo.S_Medewerker3_nvrtrw
(
        [H_Medewerker3Hashkey]
	   ,[hoogste_opleiding]
	   ,[bril_dragend]
	   ,[schoenmaat]
	   ,[meta_record_source]
	   ,[meta_load_date]
	   ,[meta_create_time]
)
select 
        stg.[hashkey]            as [H_Medewerker3Hashkey]
	   ,stg.[hoogste_opleiding]
	   ,stg.[bril_dragend]
	   ,stg.[schoenmaat]
	   ,stg.[meta_record_source]
	   ,stg.[meta_load_date]
	   ,stg.[meta_create_time]
from TestStagingDB3.dbo.Medewerker3 stg
-- Voeg alleen nieuwe nog niet voorkomende records toe in de SAT
where not exists
      (   select 'dummy'
	      from TestIntegrationDB3.dbo.S_Medewerker3_nvrtrw sat
		  where 1=1
            and sat.H_Medewerker3Hashkey = stg.hashkey
			-- datum en tijd zijn niet van belang
			and (
			      -- verschillen detectie
			      -- gebruik coalese voor niet verplichte velden om te testen
			      -- ivm perdefinitie NULL <> NULL
  	               COALESCE(sat.[hoogste_opleiding], '') =  COALESCE(stg.[hoogste_opleiding], '')
              and  COALESCE(sat.[bril_dragend], '')      =  COALESCE(stg.[bril_dragend], '')
              and  COALESCE(sat.[schoenmaat], '')        =  COALESCE(stg.[schoenmaat], '')
            ))
go

-- Load S_Medewerker3_vrtrw
insert into [TestIntegrationDB3].dbo.S_Medewerker3_vrtrw
(
        [H_Medewerker3Hashkey]
	   ,[voorletters]
	   ,[voorvoegsel]
	   ,[achternaam]
	   ,[geboortedatum]
	   ,[aow_datum]
	   ,[meta_record_source]
	   ,[meta_load_date]
	   ,[meta_create_time]
)
select 
        stg.[hashkey]            as [H_Medewerker3Hashkey]
	   ,stg.[voorletters]
	   ,stg.[voorvoegsel]
	   ,stg.[achternaam]
	   ,stg.[geboortedatum]
	   ,stg.[aow_datum]
	   ,stg.[meta_record_source]
	   ,stg.[meta_load_date]
	   ,stg.[meta_create_time]
from TestStagingDB3.dbo.Medewerker3 stg
-- Voeg alleen nieuwe nog niet voorkomende records toe in de SAT
where not exists
      (   select 'dummy'
	      from TestIntegrationDB3.dbo.S_Medewerker3_vrtrw sat
		  where 1=1
            and sat.H_Medewerker3Hashkey = stg.hashkey
			-- datum en tijd zijn niet van belang
			and (
			      -- verschillen detectie
			      -- gebruik coalese voor niet verplichte velden om te testen
			      -- ivm perdefinitie NULL <> NULL
	              COALESCE(sat.[voorletters], '')   = COALESCE(stg.[voorletters], '')
	          and COALESCE(sat.[voorvoegsel], '')   = COALESCE(stg.[voorvoegsel], '') -- dit is een kolom die NULL kan bevatten 
	          and COALESCE(sat.[achternaam], '')    = COALESCE(stg.[achternaam], '')
	          and COALESCE(sat.[geboortedatum], '') = COALESCE(stg.[geboortedatum], '')
	          and COALESCE(sat.[aow_datum], '')     = COALESCE(stg.[aow_datum], '')
           ))
go

-- load S_Organisatie_Eenheid3
insert into [TestIntegrationDB3].dbo.[S_Organisatie_Eenheid3]
(
	 [H_Organisatie_Eenheid3Hashkey]
	,[Naam]
	,[meta_record_source]
	,[meta_load_date]
	,[meta_create_time]
)
select 
        stg.[hashkey]            as [H_Organisatie_Eenheid3Hashkey]
	   ,stg.[Naam]
	   ,stg.[meta_record_source]
	   ,stg.[meta_load_date]
	   ,stg.[meta_create_time]
from TestStagingDB3.dbo.Organisatie_Eenheid3 stg
-- Voeg alleen nieuwe nog niet voorkomende records toe in de SAT
where not exists
      (   select 'dummy'
	      from TestIntegrationDB3.dbo.[S_Organisatie_Eenheid3] sat
		  where 1=1
            and sat.H_Organisatie_Eenheid3Hashkey = stg.hashkey
			-- datum en tijd zijn niet van belang
			and (
			      -- verschillen detectie
			      -- gebruik coalese voor niet verplichte velden om te testen
			      -- ivm perdefinitie NULL <> NULL
  	              COALESCE(sat.[Naam], '') =  COALESCE(stg.[Naam], '')
            ))
go

