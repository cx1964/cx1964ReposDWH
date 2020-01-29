-- vullen Facts

use [TestPresentationDB]
go

-- stap4
-- zet fk uit tbv laden
-- nog insert FACT_gepensioneerde_per_OE

-- zet fk aan na laden


-- stap3 check op dubbelen

-- stap1 vullen S_Organisatieeenheid en Dim_Organisatie eenheid

-- stap2 nog insert
-- insert into [dbo].[FACT_gepensioneerde_per_OE]
-- Hoogste niveau select tbv om meta hub gegevens te joinen aan resultaat
select
        do.[organisatie_eenheid_key]
        -- resultaat.code
       ,resultaat.aantal_gepensioneerden
	   ,rh.meta_record_source
	   ,rh.meta_load_date
	   ,rh.meta_create_time
from (
  -- tel alle aantallen op als resultaat
  select  
          data.h_Organisatie_EenheidHashkey
  	  	 ,data.code                           as  code
         ,sum(data.aantal)                    as aantal_gepensioneerden

  from (
    -- bepaal per organisatie eenheid medewerkers met aow_datum > geboortedatum
    select 
            ho.h_Organisatie_EenheidHashkey
           ,ho.code  
           ,sm.aow_datum  
	       ,sm.geboortedatum
	       ,1 as aantal  
    from [TestIntegrationDB].[dbo].[L_Medewerker_Organisatie_Eenheid] l
    inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] ho
          on ho.h_Organisatie_EenheidHashkey = l.H_Organisatie_EenheidHashkey
    inner join [TestIntegrationDB].[dbo].[H_Medewerker] hm
          on hm.H_MedewerkerHashkey = l.H_MedewerkerHashkey
    inner join [TestIntegrationDB].[dbo].[S_Medewerker] sm
          on sm.H_MedewerkerHashkey = hm.H_MedewerkerHashkey
    where sm.aow_datum > sm.geboortedatum
    ) data
    group by data.code, data.h_Organisatie_EenheidHashkey
) resultaat
inner join  [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] rh
      on rh.h_Organisatie_EenheidHashkey = resultaat.h_Organisatie_EenheidHashkey
inner join [TestPresentationDB].[dbo].[Dim_Organisatie_Eenheid] do
      on do.code = resultaat.code 