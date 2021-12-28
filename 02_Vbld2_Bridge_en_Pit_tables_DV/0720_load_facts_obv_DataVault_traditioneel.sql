-- vullen Facts obv tranditionele manier (zonder bridge table)

-- Methode1 obv Hashkey zonder Look-up naar HUB en DIM
-- in commentaar Methode2 obv fk van facts middels Look-up naar HUB en DIM

use [TestPresentationDB2]
go

-- FKs uitzetten is al gedaan (bij laden van de speciale DIM records)

truncate table [dbo].[FACT_gepensioneerde_per_OE]

-- Methode 1
-- Tbv onafhankelijk laden, 
-- Dwz parallel DIMs en FACts laden in DataMart
-- Parallel laden is alleen mogelijk las in de DIMs hashkeys als surrogate keys worden gebruikt,
-- waarbij de surrogate keys de hashkeys van de HUBs zijn uit de DataVault en
-- de foreign keys in de FACTs verwijzen naar deze Hhash keys van de DIMs

insert into [dbo].[FACT_gepensioneerde_per_OE]
-- Hoogste niveau select tbv om meta hub gegevens te joinen aan resultaat
select
          -- *** Keys naar DIMs ***
          -- oud obv lookup op DIM do.[organisatie_eenheid_key]         as [Organisatie_Eenheid_key]
 
          -- nieuw
          -- fk naar surrogate key van de Dim_Organisatie_Eenheid2 obv hashkeys
          resultaat.H_Organisatie_Eenheid2Hashkey    as [H_Organisatie2HashKey]
          
         -- *** Measures ***
         ,resultaat.aantal_gepensioneerden           as [aantal_gepensioneerden]
          
         -- *** Meta data ***
         ,resultaat.meta_record_source               as [meta_record_source]
         ,resultaat.meta_load_date                   as [meta_load_date]
         ,resultaat.meta_create_time                 as [meta_create_time]
from (
  -- tel alle aantallen op als resultaat
  select  
          data.h_Organisatie_Eenheid2Hashkey  as h_Organisatie_Eenheid2Hashkey
         ,sum(data.aantal)                    as aantal_gepensioneerden
         -- neem vanwege de group by de min alle Meta gegevens van de SATs
		 -- gebruik de min zodat altijd de oudste gegevens worden genomen uit de SATs
         ,min(data.meta_record_source)        as meta_record_source 
         ,min(data.meta_load_date)            as meta_load_date
	     ,min(data.meta_create_time)          as meta_create_time
  from (
    -- Bepaal per organisatie eenheid medewerkers waarvoor geldt:
    --
    --    convert(date, getdate()) > aow_datm
    --
    -- Medewerkers met convert(date, getdate()) > aow_datum zijn met pensioen.
    select 
              l.H_Organisatie_Eenheid2Hashkey 
             ,sm.aow_datum  
             ,sm.geboortedatum
             ,1 as aantal
             -- Meta gegevens uit SAT
             ,sm.meta_record_source
             ,sm.meta_load_date
	         ,sm.meta_create_time
    from [TestIntegrationDB2].[dbo].[L_Medewerker2_Organisatie_Eenheid2] l
    inner join [TestIntegrationDB2].[dbo].[S_Medewerker2_vrtrw] sm
          on sm.H_Medewerker2Hashkey = l.H_Medewerker2Hashkey
    where 1=1
      and convert(date, getdate()) > sm.aow_datum
  ) data
    --group by data.code, data.h_Organisatie_EenheidHashkey
    group by data.H_Organisatie_Eenheid2Hashkey
) resultaat
-- niet meer nodig: Look-ups naar HUB en DIM
-- niet meer nodig: inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] rh
-- niet meer nodig:       on rh.h_Organisatie_EenheidHashkey = resultaat.h_Organisatie_EenheidHashkey
-- niet meer nodig: inner join [TestPresentationDB].[dbo].[Dim_Organisatie_Eenheid] do
-- niet meer nodig:       on do.code = resultaat.code 



-- Methode 2
-- Tbv afhankelijk laden, dwz eerste DIMs en dan FACTs laden 
-- Dwz niet parallel laden DataMart
-- Onderstaande query werkt als de DIMs als PK hebben die bestaat uit een IDENTITY column
--
--insert into [dbo].[FACT_gepensioneerde_per_OE]
---- Hoogste niveau select tbv om meta hub gegevens te joinen aan resultaat
--select
--        -- Keys naar DIMs
--        do.[organisatie_eenheid_key]         as [Organisatie_Eenheid_key]

--        -- debug:  resultaat.code
		
--		-- Measures
--       ,resultaat.aantal_gepensioneerden     as [aantal_gepensioneerden]
	   
--	   -- Meta data
--	   ,rh.meta_record_source                as [meta_record_source]
--	   ,rh.meta_load_date                    as [meta_load_date]
--	   ,rh.meta_create_time                  as [meta_create_time]
--from (
--  -- tel alle aantallen op als resultaat
--  select  
--          data.h_Organisatie_EenheidHashkey
--  	  	 ,data.code                           as  code
--         ,sum(data.aantal)                    as aantal_gepensioneerden
--  from (
--    -- bepaal per organisatie eenheid medewerkers met aow_datum > geboortedatum
--    select 
--            ho.h_Organisatie_EenheidHashkey
--           ,ho.code  
--           ,sm.aow_datum  
--	       ,sm.geboortedatum
--	       ,1 as aantal  
--    from [TestIntegrationDB].[dbo].[L_Medewerker_Organisatie_Eenheid] l
--    inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] ho
--          on ho.h_Organisatie_EenheidHashkey = l.H_Organisatie_EenheidHashkey
--    inner join [TestIntegrationDB].[dbo].[H_Medewerker] hm
--          on hm.H_MedewerkerHashkey = l.H_MedewerkerHashkey
--    inner join [TestIntegrationDB].[dbo].[S_Medewerker] sm
--          on sm.H_MedewerkerHashkey = hm.H_MedewerkerHashkey
--    where sm.aow_datum > sm.geboortedatum
--    ) data
--    group by data.code, data.h_Organisatie_EenheidHashkey
--) resultaat
---- 2 joins tbv Lookup naar DIM
--inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] rh
--      on rh.h_Organisatie_EenheidHashkey = resultaat.h_Organisatie_EenheidHashkey
--inner join [TestPresentationDB].[dbo].[Dim_Organisatie_Eenheid] do
--      on do.code = resultaat.code 


-- voeg FK weer toe na laden
ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE]  WITH CHECK ADD  CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Dim_Organisatie_Eenheid] FOREIGN KEY([H_Organisatie2HashKey])
REFERENCES [dbo].[Dim_Organisatie_Eenheid] ([H_Organisatie2HashKey]);
GO
ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE] CHECK CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Dim_Organisatie_Eenheid];
GO