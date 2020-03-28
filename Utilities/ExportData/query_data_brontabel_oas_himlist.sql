use dwh_stg;
go

select count(*) as aantal_records
from dwh_stg.codafin12.oas_himlist;
go

select *
from dwh_stg.codafin12.oas_himlist;
go