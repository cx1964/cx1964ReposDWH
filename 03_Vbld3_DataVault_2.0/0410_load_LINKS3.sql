-- vullen link L_Medewerker3_Organisatie_Eenheid3

use [TestIntegrationDB3]
go

insert into L_Medewerker3_Organisatie_Eenheid3
--
-- Het opzoeken (tijdens het vullen van de LINK tabel) van de parent bij het child record vindt plaats obv
-- een INNER JOIN obv de FK tussen child record en parent record, omdat
-- Alleen alle child records die een parent hebben in de LINK zitten. Om te bepalen welke child records
-- geen relatie hebben met de parent kan bepaald worden door de set operatie HUB MINUS LINK op het niveau van de hash van de business key.
--
select distinct
                HASHBYTES('SHA2_256', str(eerste.nr)+str(os.code)) as [L_Medewerker_Organisatie_EenheidHashkey]
                --  ,eerste.id
                --  ,eerste.nr
			   ,eerste.hashkey as H_Medewerker3Hashkey
                -- ,os.id
			    -- ,os.code
			   ,os.hashkey as H_Organisatie3HashKey
			   ,m.meta_record_source
               ,eerste.meta_load_date
	           ,eerste.meta_create_time
from (

             -- Selecteer alleen records uit staging met de oudste datum 
			 -- Filter op tabel met FK dwz, hier Medewerker 
             select
			          ms.[hashkey] as hashkey
			         ,ms.[id] as id -- primary key 
                     ,ms.[nr] as nr -- business key
                     ,min(ms.[meta_load_date])   as meta_load_date
                     ,min(ms.[meta_create_time]) as meta_create_time
             from [TestStagingDB3].[dbo].[Medewerker3] ms -- tabel met fk
             group by ms.id, ms.nr, ms.hashkey -- business key 
	 ) eerste
inner join [TestStagingDB3].[dbo].[Medewerker3] m
      on m.id = eerste.id
inner join [TestStagingDB3].[dbo].[Organisatie_Eenheid3] os -- parent tabel
      on os.id = m.werkt_voor_org_eenheid

-- Voeg alleen nog LINKs toe die nog niet voor koemen in de LINK tabel
and not exists
(
   select 'dummy'
   from L_Medewerker3_Organisatie_Eenheid3 lmo
    where 1=1
	  and lmo.H_Medewerker3Hashkey = eerste.hashkey
	  and lmo.H_Organisatie_Eenheid3Hashkey = os.hashkey
)

