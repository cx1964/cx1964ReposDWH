-- vullen link L_Medewerker2_Organisatie_Eenheid2

use [TestIntegrationDB2]
go

insert into L_Medewerker2_Organisatie_Eenheid2
select distinct
                HASHBYTES('SHA2_256', str(eerste.nr)+str(os.code)) as [L_Medewerker_Organisatie_EenheidHashkey]
                --  ,eerste.id
                --  ,eerste.nr
			   ,eerste.hashkey as H_Medewerker2Hashkey
                -- ,os.id
			    -- ,os.code
			   ,os.hashkey as H_Organisatie2HashKey
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
             from [TestStagingDB2].[dbo].[Medewerker2] ms -- tabel met fk
             group by ms.id, ms.nr, ms.hashkey -- business key 
	 ) eerste
inner join [TestStagingDB2].[dbo].[Medewerker2] m
      on m.id = eerste.id
inner join [TestStagingDB2].[dbo].[Organisatie_Eenheid2] os -- parent tabel
      on os.id = m.werkt_voor_org_eenheid

-- Voeg alleen nog LINKs toe die nog niet voor koemen in de LINK tabel
and not exists
(
   select 'dummy'
   from L_Medewerker2_Organisatie_Eenheid2 lmo
    where 1=1
	  and lmo.H_Medewerker2Hashkey = eerste.hashkey
	  and lmo.H_Organisatie_Eenheid2Hashkey = os.hashkey
)

