-- File: 0615_load_dims_obv_DataVault_traditioneel_Obv_alle_SAT_recs.sql

-- vullen Dims

use [TestPresentationDB3]
go

-- Geen truncate anders zijn de speciale records weg.
-- truncate table Dim_Organisatie_Eenheid_Compleet;
-- truncate table Dim_Medewerker_Compleet;
-- go



-- *** eerste select query ****

-- insert into Dim_Organisatie_eenheid
insert into [Dim_Organisatie_Eenheid_Compleet]
(
       --hashkey + loaddatum + laadtijd  tbv surrogate key
       [H_Organisatie3HashKey]
      ,[meta_load_date]
      ,[meta_create_time]
      -- Business key 
      ,[code]
       -- Properties
      ,[naam]
      ,[meta_record_source]
)
select 
         --hashkey + loaddatum + laadtijd tbv surrogate key
         h.h_Organisatie_Eenheid3Hashkey
        ,s.meta_load_date
        ,s.meta_create_time
         -- Business key 
        ,h.code
         -- Properties
        ,s.naam
         -- Meta data
        ,h.meta_record_source
from [TestIntegrationDB3].[dbo].[H_Organisatie_Eenheid3] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB3].[dbo].[S_Organisatie_Eenheid3] s
      on s.H_Organisatie_Eenheid3Hashkey = h.h_Organisatie_Eenheid3Hashkey
go


-- *** eerste select query ****

--insert into Dim_Medewerker
insert into [Dim_Medewerker_Compleet]
(
      --hashkey tbv surrogate key
       [H_Medewerker3Hashkey]
      ,[meta_load_date]
      ,[meta_create_time]  
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
         --hashkey + loaddatum + laadtijd tbv surrogate key
         h.H_Medewerker3Hashkey
        ,s.meta_load_date
        ,s.meta_create_time
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
from [TestIntegrationDB3].[dbo].[H_Medewerker3] h
-- Obv Boek Dan Linstedt vind join tussen HUB en SAT plaats obv left join
-- zodat je ook een DIM record kan hebben met alleen een business key en zonder properties
left join [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw] s
      on s.H_Medewerker3Hashkey = h.H_Medewerker3Hashkey 
go