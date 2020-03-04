-- vullen sat S_Medewerker en S_Organisatie_Eenheid


use [TestIntegrationDB3]
go

-- load S_Medewerker3_nvrtrw
insert into [TestIntegrationDB3].dbo.S_Medewerker3_nvrtrw
(
        [H_Medewerker3Hashkey]
	   ,[hoogste_opleiding]
	   ,[bril_dragend]
	   ,[schoenmaat]
	   ,[meta_record_source]
	   ,[meta_load_date]
	   ,[meta_create_time]
)
select 
        stg.[hashkey]            as [H_Medewerker3Hashkey]
	   ,stg.[hoogste_opleiding]
	   ,stg.[bril_dragend]
	   ,stg.[schoenmaat]
	   ,stg.[meta_record_source]
	   ,stg.[meta_load_date]
	   ,stg.[meta_create_time]
from TestStagingDB3.dbo.Medewerker3 stg
-- Voeg alleen nieuwe nog niet voorkomende records toe in de SAT
left join TestIntegrationDB3.dbo.S_Medewerker3_nvrtrw sat
      on (    sat.H_Medewerker3Hashkey = stg.hashkey
          and sat.meta_load_date = stg.meta_load_date
          and sat.meta_create_time = stg.meta_create_time
      )
go

-- Load S_Medewerker3_vrtrw
go

-- load S_Organisatie_Eenheid3
go

