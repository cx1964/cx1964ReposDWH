-- File: pit_query_tmp.sql

use [TestIntegrationDB3];
go

-- aanleiding: https://danischnider.wordpress.com/2015/11/12/loading-dimensions-from-a-data-vault-model/

-- Doc:
-- t-sql over: https://docs.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql?view=sql-server-ver15
-- t-sql parition by: 

-- *** Uitzoeken LEAD en MAX functie mbt parition voor PIT query *****

-- combineren van brondata die gesplitst in DataVault in meerdere SATs 
select 'combineren van brondata die gesplitst in DataVault in meerdere SATs' as functie;
go

WITH load_timestamps AS (
      SELECT [H_Medewerker3Hashkey], meta_load_date, meta_create_time FROM [dbo].[S_Medewerker3_nvrtrw]
      UNION
      SELECT [H_Medewerker3Hashkey], meta_load_date, meta_create_time FROM [dbo].[S_Medewerker3_vrtrw]
	  )
----select *
----from load_date
--INSERT INTO dbo.Dim_Medewerker_Pit
--(
--     [H_Medewerker3Hashkey]
--    ,[meta_load_date]
--    ,[meta_load_date]

--)
SELECT
         LD.[H_Medewerker3Hashkey]
        ,LEAD(convert( datetime2
                      ,convert(varchar(10), nvrtrw.meta_load_date) + ' ' +convert(varchar(18), nvrtrw.meta_create_time)
			         ) 
			 ) OVER (
		       PARTITION BY LD.H_Medewerker3Hashkey
		       ORDER BY convert(  datetime2
                                 ,convert(varchar(10), nvrtrw.meta_load_date) + ' ' +convert(varchar(18), nvrtrw.meta_create_time)
			                   ) 
		 ) timestamp_nvrtrw
   --     ,MAX(vrtrw.meta_load_date, vrtrw.meta_create_time) OVER (
		 -- PARTITION BY LD.H_Medewerker3Hashkey
		 -- ORDER BY LD.meta_load_date, LD.meta_create_time
		 --) meta_load_date_vrtrw
FROM load_timestamps LD
LEFT JOIN[dbo].[S_Medewerker3_nvrtrw] nvrtrw
     ON (      nvrtrw.H_Medewerker3Hashkey = LD.H_Medewerker3Hashkey
           AND nvrtrw.meta_load_date = LD.meta_load_date)
LEFT JOIN [dbo].[S_Medewerker3_vrtrw] vrtrw
     ON (        vrtrw.H_Medewerker3Hashkey = LD.H_Medewerker3Hashkey
	         AND vrtrw.meta_load_date = LD.meta_load_date);

-- LOAD_DATE,
-- S1_LOAD_DATE,
-- S2_LOAD_DATE,
-- S3_LOAD_DATE,
-- S4_LOAD_DATE)
--WITH LOAD_DATES AS (
-- SELECT H_CUSTOMER_SID, LOAD_DATE FROM S_CUSTOMER_MAIN
-- UNION
-- SELECT H_CUSTOMER_SID, LOAD_DATE FROM S_CUSTOMER_ADDRESS
-- UNION
-- SELECT H_CUSTOMER_SID, LOAD_DATE FROM S_CUSTOMER_ONLINE
-- UNION
-- SELECT H_CUSTOMER_SID, LOAD_DATE FROM S_CUSTOMER_PHONE
--)
--SELECT
-- LD.H_CUSTOMER_SID,
-- LD.LOAD_DATE,
-- LEAD(LD.LOAD_DATE) OVER
-- (PARTITION BY LD.H_CUSTOMER_SID ORDER BY LD.LOAD_DATE) LOAD_END_DATE,
-- MAX(S1.LOAD_DATE) OVER
-- (PARTITION BY LD.H_CUSTOMER_SID ORDER BY LD.LOAD_DATE) S1_LOAD_DATE,
-- MAX(S2.LOAD_DATE) OVER
-- (PARTITION BY LD.H_CUSTOMER_SID ORDER BY LD.LOAD_DATE) S2_LOAD_DATE,
-- MAX(S3.LOAD_DATE) OVER
-- (PARTITION BY LD.H_CUSTOMER_SID ORDER BY LD.LOAD_DATE) S3_LOAD_DATE,
-- MAX(S4.LOAD_DATE) OVER
-- (PARTITION BY LD.H_CUSTOMER_SID ORDER BY LD.LOAD_DATE) S4_LOAD_DATE
--FROM LOAD_DATES LD
--LEFT JOIN S_CUSTOMER_MAIN S1
--ON (S1.H_CUSTOMER_SID = LD.H_CUSTOMER_SID AND S1.LOAD_DATE = LD.LOAD_DATE)
--LEFT JOIN S_CUSTOMER_ADDRESS S2
--ON (S2.H_CUSTOMER_SID = LD.H_CUSTOMER_SID AND S2.LOAD_DATE = LD.LOAD_DATE)
--LEFT JOIN S_CUSTOMER_ONLINE S3
--ON (S3.H_CUSTOMER_SID = LD.H_CUSTOMER_SID AND S3.LOAD_DATE = LD.LOAD_DATE)
--LEFT JOIN S_CUSTOMER_PHONE S4
--ON (S4.H_CUSTOMER_SID = LD.H_CUSTOMER_SID AND S4.LOAD_DATE = LD.LOAD_DATE);



-- hulp queries
--select nvrtrw.meta_load_date,nvrtrw.meta_create_time 
--from dbo.S_Medewerker3_nvrtrw nvrtrw;
--go
--select  convert( datetime2
--                ,convert(varchar(10), nvrtrw.meta_load_date) + ' ' +convert(varchar(18), nvrtrw.meta_create_time)
--			   ) 
--from dbo.S_Medewerker3_nvrtrw nvrtrw;
--go
