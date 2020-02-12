-- vullen Dims

use [TestPresentationDB2]
go

-- insert into Dim_Organisatie_eenheid
SET IDENTITY_INSERT dbo.Dim_Organisatie_eenheid OFF;  
go
insert into [Dim_Organisatie_Eenheid]
(
      -- Business key 
       [code]
      -- Properties
      ,[naam]
	  ,[meta_record_source]
	  ,[meta_load_date]
	  ,[meta_create_time]
)
select 
        -- Business key 
         h.code
        -- Properties
		,s.naam
		-- Meta data
		,h.meta_record_source
		,h.meta_load_date
		,h.meta_create_time
from [TestIntegrationDB].[dbo].[H_Organisatie_Eenheid] h
inner join [TestIntegrationDB].[dbo].[S_Organisatie_Eenheid] s
      on s.H_Organisatie_EenheidHashkey = h.h_Organisatie_EenheidHashkey
go

-- OK
--insert into Dim_Medewerker
SET IDENTITY_INSERT dbo.Dim_Medewerker OFF;  
go  
insert into [Dim_Medewerker]
(
      -- Business key 
       [nr]
      -- Properties
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
	  -- Meta data
	  ,[meta_record_source]
	  ,[meta_load_date]
	  ,[meta_create_time]
)
select 
         -- Business key
         h.nr
		 -- Properties
	    ,s.voorletters
        ,s.voorvoegsel
        ,s.achternaam
        ,s.geboortedatum
        ,s.aow_datum
		-- Meta data
		,h.meta_record_source
		,h.meta_load_date
		,h.meta_create_time
from [TestIntegrationDB].[dbo].[H_Medewerker] h
inner join [TestIntegrationDB].[dbo].[S_Medewerker] s
      on s.H_MedewerkerHashkey = h.H_MedewerkerHashkey 
go