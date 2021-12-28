-- vullen sat S_Medewerker_nvrtrw

-- Artikel over merge statement
-- https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/


use [TestIntegrationDB2]
go

DROP PROCEDURE [dbo].[Load_S_Medewerker2_nvrtrw]
GO

CREATE PROCEDURE Load_S_Medewerker2_nvrtrw
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
INSERT INTO S_Medewerker2_nvrtrw
( 
    -- Hub key 
	 [H_Medewerker2Hashkey]
    -- Properties    
    ,[hoogste_opleiding]
    ,[bril_dragend]
    ,[schoenmaat]
    --,LoadProcess -- niet gebruikt
    -- Meta gegevens
    ,[meta_record_source]
    ,[meta_load_date]
    ,[meta_create_time]
    ,[meta_load_end_date]
    ,[meta_create_end_time]
    ,[meta_IsCurrent]
)
SELECT
     [H_Medewerker2Hashkey]
    ,[hoogste_opleiding]
    ,[bril_dragend]
    ,[schoenmaat]
    -- ,@LoadProcess as LoadProcess
    ,@RecordSource       as [meta_record_source]     
    ,@LoadDate           as [meta_load_date]        -- Actual DateTimeStamp
	,@LoadTime           as [meta_create_time]
    ,@DefaultLoadEndDate as [meta_load_end_date]    -- Default Expiry DateTimestamp
	,@DefaultLoadEndTime as [meta_create_end_time]
	,1                   as [meta_IsCurrent]        -- IsCurrent Flag
FROM 
(
     MERGE S_Medewerker2_nvrtrw AS Target             --Target: Satellite
     USING 
     (
          -- Query distinct set of attributes from source (stage)
          -- includes lookup of business key by left outer join referenced hub/link
          SELECT distinct
             -- weg hub.[H_MedewerkerHashkey] ******************** weg
             stage.[hashkey]  as H_Medewerker2Hashkey
            ,stage.[hoogste_opleiding]
            ,stage.[bril_dragend]
            ,stage.[schoenmaat]
          FROM [TestStagingDB2].[dbo].[Medewerker2] as stage

          -- start weg ***
          --LEFT OUTER JOIN [TestIntegrationDB].[dbo].[H_Medewerker] as hub
          -- on stage.Nr=hub.Nr
          --WHERE hub.[H_MedewerkerHashkey] is not null
          -- eind weg ***


     ) AS Source
     ON Target.[H_Medewerker2Hashkey] = Source.[H_Medewerker2Hashkey] --Identify Columns by Hub/Link Surrogate Key
     AND Target.meta_IsCurrent = 1                                  --and only merge against current records in the target
     --when record already exists in satellite and an attribute value changed
     WHEN MATCHED AND
     (   
       -- verschillen detectie  
  	      Target.[hoogste_opleiding] <> Source.[hoogste_opleiding]
       OR Target.[bril_dragend]      <> Source.[bril_dragend]
       OR Target.[schoenmaat]        <> Source.[schoenmaat]
     )
     -- then outdate the existing record
     THEN UPDATE SET
           meta_IsCurrent  = 0
          ,meta_load_end_date = @LoadDate 
		  ,meta_create_end_time = @LoadTime 
     -- when record not exists in satellite, insert the new record
     WHEN NOT MATCHED BY TARGET
     THEN INSERT 
     (
          [H_Medewerker2Hashkey]
         ,[hoogste_opleiding]
         ,[bril_dragend]
         ,[schoenmaat]
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
           Source.H_Medewerker2Hashkey
		  ,Source.[hoogste_opleiding]
          ,Source.[bril_dragend]
          ,Source.[schoenmaat]
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
AND  [H_Medewerker2Hashkey] IS NOT NULL;
 

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
