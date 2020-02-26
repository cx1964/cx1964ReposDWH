-- File: 0715_load_dims_obv_DataVault_traditioneel_Obv_alle_SAT_recs.sql

-- vullen Dims

use [TestPresentationDB2]
go

-- *** eerste select query ****

-- insert into Dim_Organisatie_eenheid
insert into [Dim_Organisatie_Eenheid_Compleet]
(
       --hashkey + loaddatum + laadtijd  tbv surrogate key
       [H_Organisatie2HashKey]
      ,[meta_load_date]
      ,[meta_create_time]
      ,[meta_load_end_date]
      ,[meta_create_end_time]
      -- Business key 
      ,[code]
       -- Properties
      ,[naam]
      ,[meta_record_source]
)
select 
         --hashkey + loaddatum + laadtijd + end loaddatum en tijd tbv surrogate key
         h.h_Organisatie_Eenheid2Hashkey
        ,s.meta_load_date --h.meta_load_date
        ,s.meta_create_time --,h.meta_create_time
        ,s.meta_load_end_date
        ,s.meta_create_end_time
         -- Business key 
        ,h.code
         -- Properties
        ,s.naam
         -- Meta data
        ,h.meta_record_source
from [TestIntegrationDB2].[dbo].[H_Organisatie_Eenheid2] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB2].[dbo].[S_Organisatie_Eenheid2] s
      on s.H_Organisatie_Eenheid2Hashkey = h.h_Organisatie_Eenheid2Hashkey
go


-- *** eerste select query ****

--insert into Dim_Medewerker
insert into [Dim_Medewerker_Compleet]
(
      --hashkey tbv surrogate key
       [H_Medewerker2Hashkey]
      ,[meta_load_date]
      ,[meta_create_time]  
      ,[meta_load_end_date]
      ,[meta_create_end_time]       
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
)
select 
         --hashkey + loaddatum + laadtijd + end loaddatum en tijd tbv surrogate key
         h.H_Medewerker2Hashkey
        ,s.meta_load_date -- h.meta_load_date
        ,s.meta_create_time -- h.meta_create_time
        ,s.meta_load_end_date
        ,s.meta_create_end_time        
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
from [TestIntegrationDB2].[dbo].[H_Medewerker2] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB2].[dbo].[S_Medewerker2_vrtrw] s
      on s.H_Medewerker2Hashkey = h.H_Medewerker2Hashkey 
go