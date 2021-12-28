-- file: 0950_testen_vergelijken_dim_medewerker_compleet_en_Pit.sql
-- Functie: vergelijk aantal records Dim_Medewerker_Compleet met Dim_Medewerker_pit
--          Tbv testen
--          Indein beide excepts geen records oplevert zijn beide tabellen identiek.

use [TestPresentationDB3];
go

select 
        -- PK
	    [H_Medewerker3Hashkey]
	   ,[meta_load_date_nvrtrw]
	   ,[meta_create_time_nvrtrw]
	   ,[meta_load_date_vrtrw]
	   ,[meta_create_time_vrtrw]

       -- Business key
       ,[nr] [varchar]
 
        -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding]
       ,[bril_dragend]
       ,[schoenmaat]

	    -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters]
       ,[voorvoegsel]
       ,[achternaam]
       ,[geboortedatum]
       ,[aow_datum]

         -- Meta data
       ,meta_record_source

from [TestPresentationDB3].[dbo].Dim_Medewerker_Compleet
except
select 
        -- PK
	    [H_Medewerker3Hashkey]
	   ,[meta_load_date_nvrtrw]
	   ,[meta_create_time_nvrtrw]
	   ,[meta_load_date_vrtrw]
	   ,[meta_create_time_vrtrw]

       -- Business key
       ,[nr] [varchar]
 
        -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding]
       ,[bril_dragend]
       ,[schoenmaat]

	    -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters]
       ,[voorvoegsel]
       ,[achternaam]
       ,[geboortedatum]
       ,[aow_datum]

         -- Meta data
       ,meta_record_source
from [TestPresentationDB3].[dbo].Dim_Medewerker_Pit
go

select 
        -- PK
	    [H_Medewerker3Hashkey]
	   ,[meta_load_date_nvrtrw]
	   ,[meta_create_time_nvrtrw]
	   ,[meta_load_date_vrtrw]
	   ,[meta_create_time_vrtrw]


       -- Business key
       ,[nr] [varchar]
 
        -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding]
       ,[bril_dragend]
       ,[schoenmaat]

	    -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters]
       ,[voorvoegsel]
       ,[achternaam]
       ,[geboortedatum]
       ,[aow_datum]

         -- Meta data
       ,meta_record_source
from [TestPresentationDB3].[dbo].Dim_Medewerker_Pit
except
select 
        -- PK
	    [H_Medewerker3Hashkey]
	   ,[meta_load_date_nvrtrw]
	   ,[meta_create_time_nvrtrw]
	   ,[meta_load_date_vrtrw]
	   ,[meta_create_time_vrtrw]


       -- Business key
       ,[nr] [varchar]
 
        -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding]
       ,[bril_dragend]
       ,[schoenmaat]

	    -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters]
       ,[voorvoegsel]
       ,[achternaam]
       ,[geboortedatum]
       ,[aow_datum]

         -- Meta data
       ,meta_record_source

from [TestPresentationDB3].[dbo].Dim_Medewerker_Compleet
go

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [H_Medewerker3Hashkey]
      ,[meta_load_date_nvrtrw]
      ,[meta_create_time_nvrtrw]
      ,[meta_load_date_vrtrw]
      ,[meta_create_time_vrtrw]
      ,[nr]
      ,[hoogste_opleiding]
      ,[bril_dragend]
      ,[schoenmaat]
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
      ,[meta_record_source]
FROM [TestPresentationDB3].[dbo].[Dim_Medewerker_Compleet]

SELECT TOP (1000) [H_Medewerker3Hashkey]
      ,[meta_load_date]
      ,[meta_create_time]
      ,[nvrtrw_change_hashkey]
      ,[vrtrw_change_hashkey]
      ,[nr]
      ,[meta_load_date_nvrtrw]
      ,[meta_create_time_nvrtrw]
      ,[hoogste_opleiding]
      ,[bril_dragend]
      ,[schoenmaat]
      ,[meta_load_date_vrtrw]
      ,[meta_create_time_vrtrw]
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
      ,[meta_record_source]
  FROM [TestPresentationDB3].[dbo].[Dim_Medewerker_Pit]
  go