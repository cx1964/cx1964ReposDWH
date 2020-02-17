-- vullen Dims

use [TestPresentationDB2]
go

-- insert into Dim_Organisatie_eenheid
insert into [Dim_Organisatie_Eenheid]
(
      --hashkey tbv surrogate key
       [H_Organisatie2HashKey]
      -- Business key 
      ,[code]
      -- Properties
      ,[naam]
	  ,[meta_record_source]
	  ,[meta_load_date]
	  ,[meta_create_time]
)
select 
         --hashkey tbv surrogate key
         h.h_Organisatie_Eenheid2Hashkey
        -- Business key 
        ,h.code
        -- Properties
		,s.naam
		-- Meta data
		,h.meta_record_source
		,h.meta_load_date
		,h.meta_create_time
from [TestIntegrationDB2].[dbo].[H_Organisatie_Eenheid2] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB].[dbo].[S_Organisatie_Eenheid] s
      on s.H_Organisatie_EenheidHashkey = h.h_Organisatie_Eenheid2Hashkey
go


--insert into Dim_Medewerker
insert into [Dim_Medewerker]
(
      --hashkey tbv surrogate key
        H_Medewerker2Hashkey
      -- Business key 
       ,[nr]
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
         --hashkey tbv surrogate key
         h.H_Medewerker2Hashkey
         -- Business key
        ,h.nr
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
from [TestIntegrationDB2].[dbo].[H_Medewerker2] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB2].[dbo].[S_Medewerker2_vrtrw] s
      on s.H_Medewerker2Hashkey = h.H_Medewerker2Hashkey 
go