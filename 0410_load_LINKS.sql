-- vullen link L_Medewerker_Organisatie_Eenheid

use [TestIntegrationDB]
go

insert into L_Medewerker_Organisatie_Eenheid 
select distinct
                HASHBYTES('SHA2_256', str(eerste.nr)+str(os.code)) as [L_Medewerker_Organisatie_EenheidHashkey]
                --  ,eerste.id
                --  ,eerste.nr
			   ,mh.H_MedewerkerHashkey
               -- ,os.id
			   -- ,os.code
			   ,oh.H_Organisatie_EenheidHashkey
			   ,m.meta_record_source
               ,eerste.meta_load_date
	           ,eerste.meta_create_time
from (

             -- Selecteer alleen records uit staging met de oudste datum 
			 -- Filter op tabel met FK dwz, hier Medewerker 
             select   ms.[id] as id -- primary key
                     ,ms.[nr] as nr -- business key
                     ,min(ms.[meta_load_date])   as meta_load_date
                     ,min(ms.[meta_create_time]) as meta_create_time
             from [TestStagingDB].[dbo].[Medewerker] ms -- tabel met fk
             group by ms.id, ms.nr -- business key 
	 ) eerste
inner join [TestStagingDB].[dbo].[Medewerker] m
      on m.id = eerste.id
inner join [TestStagingDB].[dbo].[Organisatie_Eenheid] os -- parent tabel
      on os.id = m.werkt_voor_org_eenheid
-- joins tbv ophalen hashkeys van de hubs
-- tbv hashkey Medewerker
inner join	[TestIntegrationDB].[dbo].[H_medewerker] mh
       on mh.nr = eerste.nr
-- tbv hashkey Organisatie_Eenheid
inner join	[TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] oh
       on oh.code = os.code
-- check alleen records toevoegen in link tabel die nog niet bekend zijn
and not exists
(
   select 'dummy'
   from L_Medewerker_Organisatie_Eenheid lmo
    where 1=1
	  and lmo.H_MedewerkerHashkey = mh.H_MedewerkerHashkey
	  and lmo.H_Organisatie_EenheidHashkey = oh.H_Organisatie_EenheidHashkey
)

