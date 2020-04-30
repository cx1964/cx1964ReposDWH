-- File: 0800_load_pit_tables.sql
-- Functie: load pit-tables

use [TestIntegrationDB3];
go

-- PIT (Point in Time) tables zijn tbv het laden van dimensie tabellen
-- PIT tabellen worden gebruikt om de performance te verbeteren mbt het laden van dimensie tabellen,\
-- waarbij de Dimensie tabel wordt geladen uit meerdere SAT tabellen.
-- De performance van het laden de DIM tabvel kan verbeterd worden obv van meerdre SATs
-- omdat tgv het gebruik van PIT tabellen, het aantal joins van de query die de DIM laad wordt teruggebracht. 

-- Zie https://www.vertabelo.com/blog/data-vault-series-the-business-data-vault/
-- Een PIT table is een tabel bestaat uit alle PKs van alle SATs van een
-- betreffende HUB aangevuld met een LOAD_DATE (PIT_LOAD_DATE)
-- de PK van de PIT table is de PK van de HUB aangevuld met de PIT_LOAD_DATE


-- #########################################
-- ToDo
-- Test 1
-- Tbv testen moet het aantal unieke hashkeys (= afleiding van business keys) overeenkomen
-- met het aantal unieke business keys in de onderliggende busines tabel Medewerker in de bron

-- Test 2
-- Onderstaande query mbt de pit-tabel is goed, als na het laden van de Pit tabel,
-- de pit tabel evenveel records bevat als de dim table op mederwerkers die gevuld wordt
-- obv de join van SATs en HUB van medewerker
-- #############################################


-- Probleem1:  Definitie PK pit table is niet uniek
-- Dit komt door alle wijzigingen in de SAT tabellen van een hub voor een bepaald hub record
-- Probleem, voor chronologie, hoe sorteer je in welke volgde obv load_date de SAT records uit de verschillende SAT tabellen.
-- Omdat data parallel wordt verwerkt kan per hub record de volgorde in de verschillende SAT tabellen pe SAT anders zijn.
-- Voorbeeld voor Hub record1 met hashkey= A en sat1_record_sa11 en sat2_record_sa21 in de tijd de records de volgorde A, sat1_record_sa11 en sat2_record_sa21 hebben
-- terwijl        Hub record1 met hashkey= B en sat1_record_sa12 en sat2_record_sa22                                   B, sat2_record_sa22 en sat1_record_sa12
-- Echter hoe krij je voor elkaar dat de records uit de SAT uit de verschillende SAT tabellen in de juiste volgorde gesorteerd worden

-- Probleem2: Wat wordt de PK van de Pit tabel, waardoor het wel unieke waarden heeft


insert into [TestIntegrationDB3].dbo.Pit_Medewerker
(
       H_Medewerker3Hashkey -- onderdeel van PK van PIT_table
      ,pit_load_date        -- onderdeel van PK van PIT_table  
	  ,pit_load_time        -- onderdeel van PK van PIT_table
      ,nvrtrw_load_date
	  ,nvrtrw_create_time
	  ,vrtrw_load_date
	  ,vrtrw_create_time
) 
select 
       new_keys.H_Medewerker3Hashkey -- onderdeel van PK van PIT_table
      ,new_keys.pit_load_date        -- onderdeel van PK van PIT_table  
	  ,new_keys.pit_load_time             -- onderdeel van PK van PIT_table
      ,s_m_nvrtrw.meta_load_date   as nvrtrw_load_date
	  ,s_m_nvrtrw.meta_create_time as nvrtrw_create_time
	  -- debug
	  ------------------------------------------- er onstaat een de 2 inner joins een cartesich product !!!!!!!!!!!!!!!!!!
	  --,s_m_nvrtrw.schoenmaat

	  ,s_m_vrtrw.meta_load_date   as vrtrw_load_date
	  ,s_m_vrtrw.meta_create_time as vrtrw_create_time
	  -- debug
	  --,s_m_vrtrw.aow_datum

from (
  select hm.[H_Medewerker3Hashkey]     as H_Medewerker3Hashkey -- onderdeel van PK van PIT_table
        ,convert(date, getdate() )     as pit_load_date -- onderdeel van PK van PIT_table  
	    ,convert(time, getdate() )     as pit_load_time -- onderdeel van PK van PIT_table
  from [TestIntegrationDB3].[dbo].[H_Medewerker3] hm
  except -- Except tbv incrementeel laden.
      --  voeg alleen records toe aan de pit die nog niet in de pit voorkomen 
  select
         -- Dit zijn de records die al in de pit voorkomen
         pm.H_Medewerker3Hashkey -- onderdeel van PK van PIT_table
        ,pm.pit_load_date -- onderdeel van PK van PIT_table  
	    ,pm.pit_load_time -- onderdeel van PK van PIT_table
  from [TestIntegrationDB3].[dbo].[Pit_Medewerker] pm
) new_keys
-- Maak een SAT tabel bij een betreffende HUB een join van die SAT aan die HUB
left join [TestIntegrationDB3].[dbo].[S_Medewerker3_nvrtrw] s_m_nvrtrw
     on s_m_nvrtrw.[H_Medewerker3Hashkey] = new_keys.[H_Medewerker3Hashkey]
-- Maak een SAT tabel bij een betreffende HUB een join van die SAT aan die HUB
left join [TestIntegrationDB3].[dbo].[S_Medewerker3_vrtrw] s_m_vrtrw
     on s_m_vrtrw.[H_Medewerker3Hashkey] = new_keys.[H_Medewerker3Hashkey]
go

-- 20200429 obv local database bevat query 6 rows

--select *
--	   ,convert(datetime2, convert(varchar(10), meta_load_date, 105) + ' ' +convert(varchar(18), meta_create_time)) as extra_date
--from dbo.S_Medewerker3_vrtrw
--where dbo.S_Medewerker3_vrtrw.H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
--order by extra_date desc
--go

--select *
--from dbo.S_Medewerker3_vrtrw
--where dbo.S_Medewerker3_vrtrw.H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
--order by meta_load_date desc, meta_create_time 
--go

--select *
--from dbo.S_Medewerker3_nvrtrw
--where dbo.S_Medewerker3_nvrtrw.H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
--go
