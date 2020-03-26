-- Filenaam: experiment_query_gen_insert_benodigde_coda_bron_tabellen_data_DWH_STG_obv_pivot_cmd.sql
-- Functie: Genereer insert statements obv de tabellen mbt de coda hierarchien: 
-- Opmerking: De pivot werkt om te kantelen maar is niet bruikbaar, omdat in de pivat een aggregate functie gebrukkt moet worden
--            waardoor je slechts 1 record per tabellen krijgt ipv alle records uit de bron tabel.
--
--          dwh_stg.codafin12.oas_element
--          dwh_stg.codafin12.oas_grplist
--          dwh_stg.codafin12.oas_himlist

use DWH_STG;
go

-- Structuur:
-- insert into <table> (<kol1>, <kol2>, .. <koln>) values (<val1>, <val2>, .. <valn>);


-- Zie https://www.sqlservertutorial.net/sql-server-basics/sql-server-pivot/

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';
 
-- select the category names
SELECT 
    @columns+=QUOTENAME(table_name+'.'+column_name) + ','
FROM 
    dwh_stg.INFORMATION_SCHEMA.COLUMNS
where 1=1
  and table_catalog = 'DWH_STG'
  and table_schema = 'codafin12'
      -- werkt niet voor een set tabellen ('oas_element'  ,'oas_grplist','oas_himlist') 
        and table_name = 'oas_element' 
ORDER BY 
    table_name,column_name;
 
-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
-- Dit genereerd 1 record voor 1 bepaald tabel
-- Omdat er meer dan 1 tabellen zijn moet er nog gelooped worden.
-- Echter omdat in de pivot alleen een aggregate functie gebruikt moet worden
-- Gaat deze constructie niet werken
SET @sql ='
SELECT * FROM   
(
    SELECT 
             table_name
            ,column_name 
    from dwh_stg.INFORMATION_SCHEMA.COLUMNS
    where 1=1
      and table_catalog = ''DWH_STG''
      and table_schema = ''codafin12''
      -- werkt niet voor een set tabellen (''oas_element'',''oas_grplist'',''oas_himlist'') 
      and table_name = ''oas_element''
) t 
PIVOT(
    max(column_name) 
    FOR column_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

