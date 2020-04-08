use [TestSourceDB3]
go

-- create python kolommen voor insert statement

select
        ',['+column_name+']\' as kol
       ,case 
	      when (lower(data_type) = 'varchar' or lower(data_type) = 'char' )
	      then
		    ',row['+''''+column_name+''''+']' 
		  else
		    ','+column_name+'_waarde'
        end as python_statement
    ,column_name, data_type, ORDINAL_POSITION
from [INFORMATION_SCHEMA].[COLUMNS]
where 1=1
  and [TABLE_NAME] = 'oas_himlist'
  and COLUMN_NAME like 'l8%'
order by ORDINAL_POSITION asc 
go