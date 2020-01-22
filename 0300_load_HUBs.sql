use [TestIntegrationDB]
go

insert into H_Organisatie_Eenheid
select distinct
                 HASHBYTES('SHA2_256', b.code) as [h_Organisatie_EenheidHashkey] -- SHA2_512 creeert een hash van 64 posities
                ,b.code as code -- logische business key
				,b.[meta_record_source]
                ,b.[meta_load_date]     as [meta_load_date]
			    ,b.[meta_create_time] as [meta_create_time]
from [TestStagingDB].[dbo].[Organisatie_Eenheid] b -- nog gebruik maken van staging !!!!!!
where
       b.code NOT IN (  select code from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] )
	--   zie tekst paragraaf 12.1.1.1. DataVault 2.0 boek waarom een test op LoadDDate voor specifieke load datum.
       --   Namelijk om staging (die meerdere laadjobs kan bevat), de meerdere loads in juiste volgorde te laden   
            --  AND ( meta_load_date = ???? =  AND meta_create_time = ??? )     *** NOG AANZETTEN ***
 -- alternatief
 order by b.code
         ,b.[meta_record_source]
         ,b.[meta_load_date]           
         ,b.[meta_create_time]


insert into H_Medewerker
select
         HASHBYTES('SHA2_256', staging.nr) as [h_MedewerkerHashkey] -- SHA2_512 creeert een hash van 64 posities
        ,staging.nr as nr -- logische business key
        ,staging.[meta_record_source]
        ,staging.[meta_load_date]
        ,staging.[meta_create_time]
from [TestStagingDB].[dbo].[Medewerker] staging
inner join (
             -- haal het eerste records uit staging
             select   [id]
                     ,[nr]
                     ,min([meta_load_date]) as meta_load_date
                     ,min([meta_create_time]) as meta_create_time
             from [TestStagingDB].[dbo].[Medewerker]
             group by id, nr -- business key
           ) eerste
		   on (     eerste.id = staging.id 
		        and eerste.meta_load_date = staging.meta_load_date
				and eerste.meta_create_time = staging.meta_create_time )
where 1=1
  -- voeg alleen nog niet bekende business keys toe  
  and staging.[nr] not in (select nr 
                           from [TestIntegrationDB].[dbo].[H_Medewerker])