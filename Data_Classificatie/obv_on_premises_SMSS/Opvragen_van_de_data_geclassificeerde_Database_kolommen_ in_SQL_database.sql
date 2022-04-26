-- file: Opvragen_van_de_data_geclassificeerde_Database_kolommen_ in_SQL_database.sql

--  functie: Opvragen van de data geclassificeerde Database kolommen in een SQL2019 database
--  doc: https://docs.microsoft.com/en-us/sql/t-sql/statements/add-sensitivity-classification-transact-sql?view=sql-server-ver15&WT.mc_id=DP-MVP-5001259
SELECT
    SCHEMA_NAME(sys.all_objects.schema_id) as SchemaName,
    sys.all_objects.name AS [TableName], sys.all_columns.name As [ColumnName],
    [Label], [Label_ID], [Information_Type], [Information_Type_ID], [Rank], [Rank_Desc]
FROM
          sys.sensitivity_classifications
left join sys.all_objects on sys.sensitivity_classifications.major_id = sys.all_objects.object_id
left join sys.all_columns on sys.sensitivity_classifications.major_id = sys.all_columns.object_id
                        and sys.sensitivity_classifications.minor_id = sys.all_columns.column_id



-- Onderstaande query kan men classificatie opvragen
-- voor databases die mbv Microsoft SQL server Management Services (SSMS  versie >17.5) is geclassificeerd
-- Onderstaande werkt voor database >= SQL2012
-- De meta data wordt vastgelegd als extended properties op de database.
-- Bron: http://workingwithdevs.com/query-return-sensitive-data-sql-server/
SELECT S.name AS schema_name, 
       T.name AS table_name, 
       C.name AS column_name, 
       TY.name AS type_name, 
       COALESCE(IT.value, N'') AS information_type, 
       COALESCE(SL.value, N'') AS sensitivity_label 
FROM sys.schemas AS S 
    JOIN sys.tables AS T 
        ON T.schema_id = S.schema_id 
    JOIN sys.columns AS C 
        ON C.object_id = T.object_id 
    JOIN sys.types AS TY 
        ON TY.user_type_id = C.user_type_id 
    LEFT OUTER JOIN sys.extended_properties AS IT 
        ON IT.major_id = C.object_id 
           AND IT.minor_id = C.column_id 
           AND IT.name = 'sys_information_type_name' 
    LEFT OUTER JOIN sys.extended_properties AS SL 
        ON SL.major_id = C.object_id 
           AND SL.minor_id = C.column_id 
           AND SL.name = 'sys_sensitivity_label_name' 
-- nbnegin toegevoegd
where 1=1
  and (    IT.value is NOT NULL
        OR SL.value IS NOT NULL )
-- einde toegevoegd
ORDER BY S.name, 
         T.name, 
         C.name                        