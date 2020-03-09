-- file: 0725_load_facts_obv_DataVault_traditioneel_obv_alle_SAT_recs.sql

-- vullen Facts obv tranditionele manier (zonder bridge table)

-- Methode1 obv Hashkey zonder Look-up naar HUB en DIM
-- en waarbij de FACTs en de DIMs parallel geladen kan worden
-- en dat de DIMs geladen wordt obv alle SAT records.

use [TestPresentationDB3]
go

-- FKs uitzetten is al gedaan (bij laden van de speciale DIM records)

truncate table [dbo].[FACT_gepensioneerde_per_OE_Compleet]

-- Methode 1
-- Tbv onafhankelijk laden, 
-- Dwz parallel DIMs en FACts laden in DataMart
-- Parallel laden is alleen mogelijk las in de DIMs hashkeys als surrogate keys worden gebruikt,
-- waarbij de surrogate keys de hashkeys van de HUBs zijn uit de DataVault en
-- de foreign keys in de FACTs verwijzen naar deze Hhash keys van de DIMs

insert into [dbo].[FACT_gepensioneerde_per_OE_Compleet]
-- Hoogste niveau select tbv om meta hub gegevens te joinen aan resultaat
select
          -- *** Keys naar DIMs ***
          -- oud obv lookup op DIM do.[organisatie_eenheid_key]         as [Organisatie_Eenheid_key]
 
          -- nieuw
          -- fk naar surrogate key van de Dim_Organisatie_Eenheid2 obv hashkeys
          resultaat.H_Organisatie_Eenheid3Hashkey    as [H_Organisatie3HashKey]
         ,resultaat.meta_load_date                   as [meta_load_date]
         ,resultaat.meta_create_time                 as [meta_create_time]

         -- *** Measures ***
         ,resultaat.aantal_gepensioneerden           as [aantal_gepensioneerden]
          
         -- *** Meta data ***
         ,resultaat.meta_record_source               as [meta_record_source]

from (
  -- tel alle aantallen op als resultaat
  select  
          data.h_Organisatie_Eenheid3Hashkey  as h_Organisatie_Eenheid3Hashkey
         ,data.meta_load_date                 as meta_load_date
         ,data.meta_create_time               as meta_create_time
         ,sum(data.aantal)                    as aantal_gepensioneerden
          -- Haal meta_record_source uit SAT en gebruik tgv grouping de MIN functie
         ,min(data.meta_record_source)        as meta_record_source 
  from (
    -- Bepaal per organisatie eenheid medewerkers waarvoor geldt:
    --
    --    convert(date, getdate()) > aow_datm
    --
    -- Medewerkers met convert(date, getdate()) > aow_datum zijn met pensioen.
    select 
              -- maak FK naar DIM_Organisatie_Eenheid_compleet
              l.H_Organisatie_Eenheid3Hashkey 
             ,so.meta_load_date  -- uit de SAT van Organisatie_Eenheid
             ,so.meta_create_time -- uit de SAT van Organisatie_Eenheid
             -- Meetwaarden 
             ,sm.aow_datum  
             ,sm.geboortedatum
             ,1 as aantal
             -- Meta gegevens uit SAT
             ,sm.meta_record_source
    from [TestIntegrationDB3].[dbo].[L_Medewerker3_Organisatie_Eenheid3] l
	-- Tbv Medewerker properties in FACT is SAT medewerker nodig
    inner join [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw] sm
          on sm.H_Medewerker3Hashkey = l.H_Medewerker3Hashkey
    -- Tbv FK velden voor de fact van FACT naar DIM_organisatieeenheid is join
	-- met SAT organisatie eenheid nodig
    inner join [TestIntegrationDB3].[dbo].[S_Organisatie_Eenheid3] so
	      on so.H_Organisatie_Eenheid3Hashkey = l.H_Organisatie_Eenheid3Hashkey
    where 1=1
      and convert(date, getdate()) > sm.aow_datum
  ) data
    --group by data.code, data.h_Organisatie_EenheidHashkey
    group by data.H_Organisatie_Eenheid3Hashkey
            ,data.meta_load_date
            ,data.meta_create_time
) resultaat
-- niet meer nodig: Look-ups naar HUB en DIM
-- niet meer nodig: inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] rh
-- niet meer nodig:       on rh.h_Organisatie_EenheidHashkey = resultaat.h_Organisatie_EenheidHashkey
-- niet meer nodig: inner join [TestPresentationDB].[dbo].[Dim_Organisatie_Eenheid] do
-- niet meer nodig:       on do.code = resultaat.code 


-- voeg FK weer toe na laden
ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet]
WITH CHECK
ADD CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Compleet_Dim_Organisatie_Eenheid_Compleet]
FOREIGN KEY(
             [H_Organisatie3HashKey]
            ,[meta_load_date]
            ,[meta_create_time]
)
REFERENCES [dbo].[Dim_Organisatie_Eenheid_Compleet] (
             [H_Organisatie3HashKey]
            ,[meta_load_date]
            ,[meta_create_time]
);
GO
