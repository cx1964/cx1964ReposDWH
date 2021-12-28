-- File: 0800_Aanpassen_SAT_data_tbv_testen_PIT_tables.sql

use [TestIntegrationDB3];
go

select 
        nvrtrw.[H_Medewerker3Hashkey]
       ,nvrtrw.[meta_load_date]
       ,nvrtrw.[meta_create_time]
	   ,nvrtrw.*
from [dbo].[S_Medewerker3_nvrtrw] nvrtrw
order by nvrtrw.[H_Medewerker3Hashkey]
go

select 
        vrtrw.[H_Medewerker3Hashkey]
       ,vrtrw.[meta_load_date]
       ,vrtrw.[meta_create_time]
	   ,vrtrw.*
from [dbo].[S_Medewerker3_vrtrw] vrtrw
order by vrtrw.[H_Medewerker3Hashkey]
go

-- aanpassingen tijdstippen voor testen PIT tabellen
update [dbo].[S_Medewerker3_nvrtrw]
set  meta_load_date = '2020-03-04'
    ,meta_create_time = '08:00'
where H_Medewerker3Hashkey = '0C<–wÍ©^‚ŒÔÅŸ‚Vù|LŠ¼ä‰±´8K'

update [dbo].[S_Medewerker3_vrtrw]
set  meta_load_date = '2020-03-06'
    ,meta_create_time = '09:45'
where H_Medewerker3Hashkey = '0C<–wÍ©^‚ŒÔÅŸ‚Vù|LŠ¼ä‰±´8K'

update [dbo].[S_Medewerker3_nvrtrw]
set  meta_load_date = '2020-03-08'
    ,meta_create_time = '12:15'
where     H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
      and meta_load_date = '2020-03-05'

update [dbo].[S_Medewerker3_nvrtrw]
set  meta_load_date = '2020-03-08'
    ,meta_create_time = '13:30'
where     H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
      and meta_load_date = '2020-03-09'

update [dbo].[S_Medewerker3_nvrtrw]
set  meta_load_date = '2020-03-09'
    ,meta_create_time = '13:30'
where     H_Medewerker3Hashkey = 'ø6ô6íGÜ‚äü;]J/û+´ßl¥ÄÄ¸ŸÁŽä'
      and meta_load_date = '2020-03-08'
	  and meta_create_time = '13:30'