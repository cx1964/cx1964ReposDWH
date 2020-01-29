-- vullen Dims

use [TestPresentationDB]
go

--insert into Dim_Organisatie_eenheid
select 
         h.code
		,s.*
		,h.meta_record_source
		,h.meta_record_source
		,h.meta_load_date
		,h.meta_create_time
from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] h
inner join [TestIntegrationDB].[dbo].[S_Organisatie_Eenheid] s on s.H_Organisatie_EenheidHashkey = h.h_Organisatie_EenheidHashkey
go

-- hulp
-- later weg
select *
from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid]

-- hulp
-- later weg
-- [TestIntegrationDB].[dbo].[S_Organisatie_Eenheid]  is nog leeg
select *
from [TestIntegrationDB].[dbo].[S_Organisatie_Eenheid] 


-- OK
SET IDENTITY_INSERT dbo.Dim_Medewerker OFF;  
go  
insert into [Dim_Medewerker]
(
       [nr]
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
	  ,[meta_record_source]
	  ,[meta_load_date]
	  ,[meta_create_time]
)
select 
         h.nr
	    ,s.voorletters
        ,s.voorvoegsel
        ,s.achternaam
        ,s.geboortedatum
        ,s.aow_datum
		,h.meta_record_source
		,h.meta_load_date
		,h.meta_create_time
from [TestIntegrationDB].[dbo].[H_Medewerker] h
inner join [TestIntegrationDB].[dbo].[S_Medewerker] s on s.H_MedewerkerHashkey = h.H_MedewerkerHashkey 
go