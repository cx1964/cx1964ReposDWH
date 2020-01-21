use [TestIntegrationDB]
go

select distinct 
                 HASHBYTES('SHA2_256', b.code) as [h_Organisatie_EenheidHashkey] -- SHA2_512 creeert een hash van 64 posities
                ,b.code as code -- logische business key
                ,convert(date, getdate()) as [meta_load_date]
			    ,convert(time, getdate()) as [meta_load_date]
from [TestSourceDB].[dbo].[Organisatie_Eenheid] b
where
       b.code NOT IN (  select code from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] )
	   -- AND  zie tekst waarom nog een test op een specifieke load datum       