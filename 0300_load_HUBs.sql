use [TestIntegrationDB]
go

select distinct 
                 HASHBYTES('SHA2_256', b.code) as [h_Organisatie_EenheidHashkey] -- SHA2_512 creeert een hash van 64 posities
                ,b.code as code -- logische business key
                ,convert(date, getdate()) as [meta_load_date]
			    ,convert(time, getdate()) as [meta_create_date]
from [TestStagingDB].[dbo].[Organisatie_Eenheid] b -- nog gebruik maken van staging !!!!!!
where
       b.code NOT IN (  select code from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] )
	--   zie tekst paragraaf 12.1.1.1. DataVault 2.0 boek waarom een test op LoadDDate voor specifieke load datum.
       --   Namelijk om staging (die meerdere laadjobs kan bevat), de meerdere loads in juiste volgorde te laden   
  --     AND ( meta_load_date = ???? =  AND meta_create_time = ??? )     