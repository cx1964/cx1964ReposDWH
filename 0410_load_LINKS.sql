-- vullen link L_Medewerker_Organisatie_Eenheid

use [TestIntegrationDB]
go


select  HASHBYTES('SHA2_256', sm.nr+so.code) as [L_Medewerker_Organisatie_EenheidHashkey] -- nog geode hashkey bepalen voor LINK key; nu nog niet uniek
       ,HASHBYTES('SHA2_256', sm.nr) as [H_MedewerkerHashkey]
	   ,HASHBYTES('SHA2_256', so.code) as [h_Organisatie_EenheidHashkey]
	   ,str(sm.id)+str(so.id)
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
