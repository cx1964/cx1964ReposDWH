-- vullen sat S_Medewerker en S_Organisatie_Eenheid

-- Artikel over merge statement
-- https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/


use [TestIntegrationDB]
go


-- nog drop toevoegen
CREATE PROCEDURE Load_S_Medewerker
AS
-- Bron: https://www.oraylis.de/blog/data-vault-satellite-loads-explained
-- Functie: Stored Procedure tbv het loaden van de SAT Medewerkek obv EndDate methode 
--
-- niet gebruikt @LoadProcess BIGINT --Identifier for the loadprocess

DECLARE @RecordSource        nvarchar(100)
DECLARE @DefaultLoadDate     date
DECLARE @DEfaultLoadTime     time   --use datetime2(0) to remove milliseconds
DECLARE @DefaultLoadEndDate  date
DECLARE @DefaultLoadEndTime  time
DECLARE @LoadDate            date
DECLARE @LoadTime            time

SET @RecordSource            = N'fictief'
SET @DefaultLoadEndTime      = '00:00:00' 
SET @DefaultLoadEndDate      = '9999-12-31'
SET @LoadDate                = convert(date, GETDATE())
SET @LoadTime                = convert(time, GETDATE())

BEGIN TRY
Begin Transaction
--Insert new current records for changed records
INSERT INTO S_Medewerker
( 
	 [H_MedewerkerHashkey]
    ,[voorletters]
    ,[voorvoegsel]
    ,[achternaam]
    ,[geboortedatum]
    ,[aow_datum]
    --	,LoadProcess -- niet gebruikt
    ,[meta_record_source]
    ,[meta_load_date]
    ,[meta_create_time]
    ,[meta_load_end_date]
	,[meta_create_end_time]
	,[meta_IsCurrent]
)
SELECT
     [H_MedewerkerHashkey]
	,[voorletters]
    ,[voorvoegsel]
    ,[achternaam]
    ,[geboortedatum]
    ,[aow_datum]
    -- ,@LoadProcess as LoadProcess
    ,@RecordSource as meta_record_source     
    ,@LoadDate                                -- Actual DateTimeStamp
	,@LoadTime
    ,@DefaultLoadEndDate                      -- Default Expiry DateTimestamp
	,@DefaultLoadEndTime
    ,1                     as meta_IsCurrent  -- IsCurrent Flag
FROM 
(
     MERGE S_Medewerker AS Target             --Target: Satellite
     USING 
     (
          -- Query distinct set of attributes from source (stage)
          -- includes lookup of business key by left outer join referenced hub/link
          SELECT distinct
             hub.[H_MedewerkerHashkey]
   	  	    ,stage.[voorletters]
            ,stage.[voorvoegsel]
            ,stage.[achternaam]
            ,stage.[geboortedatum]
            ,stage.[aow_datum]
          FROM [TestStagingDB].[dbo].[Medewerker] as stage
          LEFT OUTER JOIN [TestIntegrationDB].[dbo].[H_Medewerker] as hub on stage.Nr=hub.Nr
          WHERE hub.[H_MedewerkerHashkey] is not null
     ) AS Source
     ON Target.[H_MedewerkerHashkey] = Source.[H_MedewerkerHashkey] --Identify Columns by Hub/Link Surrogate Key
     AND Target.meta_IsCurrent = 1                                  --and only merge against current records in the target
     --when record already exists in satellite and an attribute value changed
     WHEN MATCHED AND
     (   
	      Target.[voorletters] <> Source.[voorletters]
       OR Target.[voorvoegsel] <> Source..[voorvoegsel]
       OR Target.[achternaam] <> Source.[achternaam]
       OR Target.[geboortedatum] <> Source.[geboortedatum]
       OR Target.[aow_datum] <> Source.[aow_datum]
     )
     -- then outdate the existing record
     THEN UPDATE SET
           meta_IsCurrent  = 0
          ,meta_load_end_date = @LoadDate 
		  ,meta_load_end_time = @LoadTime 
     -- when record not exists in satellite, insert the new record
     WHEN NOT MATCHED BY TARGET
     THEN INSERT 
     (
          [H_MedewerkerHashkey]
         ,[voorletters]
         ,[voorvoegsel]
         ,[achternaam]
         ,[geboortedatum]
         ,[aow_datum]
		 --,LoadProcess
         ,[meta_record_source]
         ,[meta_load_date]
         ,[meta_create_time]
         ,[meta_load_end_date]
	     ,[meta_create_end_time]
	     ,[meta_IsCurrent]
     ) 
     VALUES 
     (
           Source.H_MedewerkerHashkey
		  ,Source.[voorletters]
          ,Source.[voorvoegsel]
          ,Source.[achternaam]
          ,Source.[geboortedatum]
          ,Source.[aow_datum]
          --@LoadProcess
          ,@RecordSource
          ,@LoadDate             -- Default Effective DateTimeStamp
		  ,@LoadTime
          ,@DefaultLoadEndDate   -- Default Expiry DateTimeStamp
		  ,@DefaultLoadEndTime
          ,1                     -- IsCurrent Flag
     )
     -- Output changed records
     OUTPUT 
          $action AS Action
          ,Source.*
) AS MergeOutput
WHERE MergeOutput.Action = 'UPDATE'
AND  [H_MedewerkerHashkey] IS NOT NULL;
 

Commit
     SELECT
          'Success' as ExecutionResult
     RETURN;
END TRY
 
BEGIN CATCH
 
     IF @@TRANCOUNT > 0
     ROLLBACK
 
     SELECT
          'Failure' as ExecutionResult,
          ERROR_MESSAGE() AS ErrorMessage;
     RETURN;

END CATCH
 
GO


--MERGE [TestIntegrationDB].[dbo].[S_Medewerker] sm
--USING [TestStagingDB].[dbo].[Medewerker] stgm
--ON ( sm.H_MedewerkerHashkey =  HASHBYTES('SHA2_256', str(stgm.nr) ) ) -- hash van de business key
--WHEN MATCHED
--    -- update actie 
--    THEN 
--	     update
--	     set 
--             sm.voorletters=stgm.voorletters
--            ,sm.voorvoegsel=stgm.voorvoegsel
--		    ,sm.achternaam=stgm.achternaam
--		    ,sm.geboortedatum=stgm.geboortedatum
--		    ,sm.aow_datum=stgm.aow_datum
--WHEN NOT MATCHED BY TARGET
--     -- insert actie
--    THEN
--	    insert (
--                 [H_MedewerkerHashkey]
--                ,[voorletters]
--                ,[voorvoegsel]
--                ,[achternaam]
--                ,[geboortedatum]
--                ,[aow_datum]
--                ,[meta_record_source]
--                ,[meta_load_date]
--                ,[meta_create_time]		
--		) values(
--		   HASHBYTES('SHA2_256', str(stgm.nr))
--		  ,stgm.[voorletters]
--		  ,stgm.[voorvoegsel]
--          ,stgm.[achternaam]
--          ,stgm.[geboortedatum]
--          ,stgm.[aow_datum]
--          ,stgm.[meta_record_source]
--          ,stgm.[meta_load_date]
--          ,stgm.[meta_create_time]	
--		)	
---- geen delete actie
---- als delete actie dcan moet dit niet vergelijken sat met staging maar sat met bron
----WHEN NOT MATCHED BY SOURCE
----    -- delete actie
----    THEN 
----	     NULL
--;
--GO


-- oud
--select *
--from [TestStagingDB].[dbo].[Medewerker] stgm
---- voer wijziging door obv volgorde van datum en tijd in staging (oudste eerste, nieuweste als laast)
--left outer join [TestIntegrationDB].[dbo].[S_Medewerker] sm
--     on (     sm.H_MedewerkerHashkey =  HASHBYTES('SHA2_256', str(stgm.nr))
--	      AND sm.meta_load_date   IS NULL
--		  AND sm.meta_create_time IS NULL
--         )
--where 1=1
--  and (
--         -- change detection
--            ISNULL(stgm.voorletters, '')   != ISNULL(sm.voorletters, '')
--         OR ISNULL(stgm.voorvoegsel, '')   != ISNULL(sm.voorvoegsel, '')
--		 OR ISNULL(stgm.achternaam, '')    != ISNULL(sm.achternaam, '')
--		 OR ISNULL(stgm.geboortedatum, '') != ISNULL(sm.geboortedatum, '')
--		 OR ISNULL(stgm.aow_datum, '')     != ISNULL(sm.aow_datum, '')
--      )
--order by 
--          stgm.meta_load_date asc
--		 ,stgm.meta_create_time asc
--		 ,stgm.nr asc  -- business key