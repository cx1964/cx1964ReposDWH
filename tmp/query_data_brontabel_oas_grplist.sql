use dwh_stg;
go

select count(*) as aantal_records
from dwh_stg.codafin12.oas_grplist;
go

select *
from dwh_stg.codafin12.oas_grplist;
go