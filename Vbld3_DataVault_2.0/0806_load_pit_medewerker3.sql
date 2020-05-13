-- File: pit_query_tmp.sql
-- Aanleiding: https://danischnider.wordpress.com/2015/11/12/loading-dimensions-from-a-data-vault-model/

-- Doc:
-- t-sql over: https://docs.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql?view=sql-server-ver15
-- t-sql parition by: 

-- Verklaring:
-- Een PIT table wordt gebruikt om DIM tabel te laden voor situaties waarbij een HUB meer dan 1 SAT heeft.
-- Doodat de PIT tabel een een soort index functie vervult, is het mogelijk een DIM te creeren obv een
-- view door gebruik te maken van een PI tabel.
-- Bij het gebruik van PIT tables maak je tijdreeksen obv de loaddate en time die afkomstig zijn uit alle
-- SAT tabellen die horen bij een bepaald HUB. Deze tijdreeks onstaat door mbv een union alle 
-- loaddate en time bijelkaar te voegen. Vervolgens ontstaat de pit table door
-- de deze tijdreeks weer aan de betreffende SATs te joinen, waardoor de tijdreeks wordt aangevuld 
-- met de Hashkey uit de SATs.

use [TestIntegrationDB3];
go

-- Maak een tabel met een tijdreeks obv meta_load_date, meta_create_time uit 
-- de SAT tabellen voor HUB medewerker
-- Voor het werken met PIT tabellen, is het eigenlijk handiger om de meta_load_date, meta_create_time
-- in 1 kolom te hebben van het datatype datetime2.
-- Dit voorkomt extra type casting in queries

WITH load_timestamps AS (
       SELECT [H_Medewerker3Hashkey], meta_load_date, meta_create_time FROM [dbo].[S_Medewerker3_nvrtrw]
       UNION
       SELECT [H_Medewerker3Hashkey], meta_load_date, meta_create_time FROM [dbo].[S_Medewerker3_vrtrw]
	 ), 
     overzicht_mutaties_in_de_tijd as (
       select *
       from load_timestamps
     )
--select *
--from overzicht_mutaties_in_de_tijd
--order by 2,3,1
INSERT INTO dbo.Pit_Medewerker3
(
     [H_Medewerker3Hashkey]
    ,[pit_load_date]
    ,[pit_load_time]
    ,[nvrtrw_load_date]
    ,[nvrtrw_create_time]
    ,[vrtrw_load_date]
    ,[vrtrw_create_time]
    ,[meta_record_source]
)
SELECT   
         LD.[H_Medewerker3Hashkey]
		,convert(date, getdate()) as [pit_load_date]
		,convert(time, getdate()) as [pit_load_date]
		,coalesce(nvrtrw.meta_load_date  , '99991231') as [nvrtrw_load_date]
		,coalesce(nvrtrw.meta_create_time, '00:00:00') as [nvrtrw_create_time]
		,coalesce(vrtrw.meta_load_date   , '99991231') as [vrtrw_load_date]
		,coalesce(vrtrw.meta_create_time, '00:00:00') as [vrtrw_create_time]
		,'system'                  as [meta_record_source]
   --     ,(convert( datetime2
   --                   ,convert(varchar(10), nvrtrw.meta_load_date) + ' ' +convert(varchar(18), nvrtrw.meta_create_time)
			--         ) 

		 --) timestamp_nvrtrw
   --     ,(convert( datetime2
   --                   ,convert(varchar(10), vrtrw.meta_load_date) + ' ' +convert(varchar(18), vrtrw.meta_create_time)
			--         ) 

		 --) timestamp_vrtrw
FROM load_timestamps LD
LEFT JOIN[dbo].[S_Medewerker3_nvrtrw] nvrtrw
     ON (      nvrtrw.H_Medewerker3Hashkey = LD.H_Medewerker3Hashkey
           AND nvrtrw.meta_load_date = LD.meta_load_date
		   AND nvrtrw.meta_create_time = LD.meta_create_time
         )
LEFT JOIN [dbo].[S_Medewerker3_vrtrw] vrtrw
     ON (        vrtrw.H_Medewerker3Hashkey = LD.H_Medewerker3Hashkey
	         AND vrtrw.meta_load_date = LD.meta_load_date
		     AND vrtrw.meta_create_time = LD.meta_create_time
		 )
order by 2,1;
go

