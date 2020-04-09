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

  --and  column_name not in ( 
  --     select column_name
	 --  from [INFORMATION_SCHEMA].[COLUMNS]
	 --  where 
  --         COLUMN_NAME like 'l2%'
	 --  and COLUMN_NAME like 'l3%'
	 --  and COLUMN_NAME like 'l4%'
	 --  and COLUMN_NAME like 'l5%'
	 --  and COLUMN_NAME like 'l6%'
	 --  and COLUMN_NAME like 'l7%'
	 --  and COLUMN_NAME like 'l8%'
	 --  and COLUMN_NAME like 'l9%'
	 --  and COLUMN_NAME like 'l10%'
	 --  and [TABLE_NAME] = 'oas_himlist'
  --  )

  --and (  COLUMN_NAME like 'leaf%'
  --        or COLUMN_NAME like 'l1%'
		--  or COLUMN_NAME like 'l2%'
		--  or COLUMN_NAME like 'l3%'
		--  or COLUMN_NAME like 'l4%'
		--  or COLUMN_NAME like 'l5%'
		--  or COLUMN_NAME like 'l6%'
		--  or COLUMN_NAME like 'l7%'
		--  or COLUMN_NAME like 'l8%'
		--  or COLUMN_NAME like 'l9%'
--      )
order by
-- column_name asc
 ORDINAL_POSITION asc 
go