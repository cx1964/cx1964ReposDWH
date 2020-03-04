-- Code obv documentatie zie
-- [1]
-- Buiding a scalable Data Warehouse 
-- With Data Vault 2.0
-- Daniel Linstedt
-- Micheal Olschimke

use [TestIntegrationDB3]
go

insert into H_Organisatie_Eenheid3
select
         staging.hashkey as [H_Organisatie_EenheidHashkey] -- SHA2_512 creeert een hash van 64 posities
        ,staging.code as nr -- logische business key
        ,staging.[meta_record_source]
        ,staging.[meta_load_date]
        ,staging.[meta_create_time]
from [TestStagingDB3].[dbo].[Organisatie_Eenheid3] staging
inner join (
             -- haal het eerste records uit staging
             -- Alternatief dan genoemd in boek [1] paragraaf 12.1.1.1. tav verwerken meerdere sets in staging
             select   [id]
                     ,[code]
                     ,min([meta_load_date]) as meta_load_date
                     ,min([meta_create_time]) as meta_create_time
             from [TestStagingDB3].[dbo].[Organisatie_Eenheid3]
             group by id, code -- business key
           ) eerste
		   on (     eerste.id = staging.id 
		        and eerste.meta_load_date = staging.meta_load_date
		        and eerste.meta_create_time = staging.meta_create_time )
where 1=1
  -- voeg alleen nog niet bekende business keys toe  
  and staging.[code] not in (select code 
                             from [TestIntegrationDB3].[dbo].[H_Organisatie_Eenheid3])


insert into H_Medewerker3
select
         staging.hashkey  as [h_MedewerkerHashkey] -- SHA2_512 creeert een hash van 64 posities
        ,staging.nr as nr -- logische business key
        ,staging.[meta_record_source]
        ,staging.[meta_load_date]
        ,staging.[meta_create_time]
from [TestStagingDB3].[dbo].[Medewerker3] staging
inner join (
             -- haal het eerste records uit staging
             -- Alternatief dan genoemd in boek [1] paragraaf 12.1.1.1. tav verwerken meerdere sets in staging
             select   [id]
                     ,[nr]
                     ,min([meta_load_date]) as meta_load_date
                     ,min([meta_create_time]) as meta_create_time
             from [TestStagingDB3].[dbo].[Medewerker3]
             group by id, nr -- business key
           ) eerste
		   on (     eerste.id = staging.id 
		        and eerste.meta_load_date = staging.meta_load_date
		        and eerste.meta_create_time = staging.meta_create_time )
where 1=1
  -- voeg alleen nog niet bekende business keys toe  
  and staging.[nr] not in (select nr 
                           from [TestIntegrationDB3].[dbo].[H_Medewerker3])


-- Debug info
select *
from dbo.H_Medewerker3 

select *
from dbo.H_Organisatie_Eenheid3