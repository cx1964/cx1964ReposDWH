-- vullen link L_Medewerker_Organisatie_Eenheid

use [TestIntegrationDB]
go


select  HASHBYTES('SHA2_256', str(sm.nr)+str(so.code)) as [L_Medewerker_Organisatie_EenheidHashkey] -- nog goede hashkey bepalen voor LINK key; nu nog niet uniek
       ,HASHBYTES('SHA2_256', sm.nr) as [H_MedewerkerHashkey]
	   ,HASHBYTES('SHA2_256', so.code) as [h_Organisatie_EenheidHashkey]
	   ,concat(str(sm.id,8,0),str(so.id,8,0))+convert(varchar(24), getdate(), 121) -- test tbv hash key maken
	   ,concat(str(sm.id,8,0),str(so.id,8,0)) -- nog weg halen !!!!!!!!!!!!!!!!!!!!
	   ,sm.[meta_record_source] -- uit Medewerker omdat die de fk bevat 
       ,sm.[meta_load_date] -- uit Medewerker omdat die de fk bevat 
       ,sm.[meta_create_time] -- uit Medewerker omdat die de fk bevat 
from [TestStagingDB].[dbo].[Medewerker] sm
inner join [TestStagingDB].[dbo].[Organisatie_Eenheid] so on so.id = sm.werkt_voor_org_eenheid
-- haal hashkey uit h_medewerker
inner join [TestIntegrationDB].[dbo].[H_Medewerker] hm on hm.nr = sm.nr -- join op business key
-- haal hashkey uit h_organisatie_eenheid
inner join [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] ho on ho.code = so.code -- join op business key
where not exists
(
  -- selecteer alle nieuwe combinaties van hub hash keys uit staging die niet voor komen in de link tabel
  select  hm.[H_MedewerkerHashkey]
	     ,ho.[H_Organisatie_EenheidHashkey]
  from [TestIntegrationDB].[dbo].[L_Medewerker_Organisatie_Eenheid] l
  where 1=1
    and l.[H_MedewerkerHashkey] = hm.[H_MedewerkerHashkey]
    and l.[H_Organisatie_EenheidHashkey] = ho.[h_Organisatie_EenheidHashkey]
)


-- todo
-- onderstaande afmaken
-- als klaar kan query hierboven weg.
-- todo:
--       1. hashkey uit h_org_eenheid toevoegen
--       2. haskkey voor link maken op concat buesiness keys
--       3. na denken over hoe link bij werken als fk wijzigd in bronsysteem of fk leeg wordt

select distinct
                eerste.id
               ,eerste.nr
			   ,mh.H_MedewerkerHashkey
               ,os.id
			   ,os.code
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
-- tbv hashkey medewerker
inner join	[TestIntegrationDB].[dbo].[H_medewerker] mh
       on mh.nr = eerste.nr