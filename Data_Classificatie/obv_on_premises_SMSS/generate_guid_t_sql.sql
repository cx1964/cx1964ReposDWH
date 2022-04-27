-- file: generate_guid_t_sql
-- Functie: genereer GUIDs (unieke ids)
--          tbv label_ids in Information_Protection_Policy_handmatige_aanpassing_obv_export_default_smss_18.11.1.json
-- Doc: https://docs.microsoft.com/en-us/sql/t-sql/data-types/uniqueidentifier-transact-sql?view=sql-server-ver15
--      https://docs.microsoft.com/en-us/sql/t-sql/functions/newsequentialid-transact-sql?view=sql-server-ver15
--          Letop x wordt uniek gemaakt per hardware platform (dus unike specifiek binnen SQL server op deze machine)

-- The UuidCreateSequential function has hardware dependencies. On SQL Server, clusters of sequential values can develop when databases (such as contained databases) are moved to other computers. When using Always On and on SQL Database, clusters of sequential values can develop if the database fails over to a different computer.

-- print NEWSEQUENTIALID() 
DECLARE @myid uniqueidentifier = NEWID();  
-- SELECT CONVERT(CHAR(255), @myid) AS 'char';
SELECT CONVERT(CHAR(37), @myid) AS 'char';