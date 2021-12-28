-- File: 0825_load_dim_medewerker_obv_pit_medewerker3.toDo.sql
-- Functie: load dim_medewerker obv van pit tabel pit_medewerker3

use TestIntegrationDB3;
go

-- ToDo
--  vul Dim opbv pit_medewerk3
-- query afmaken

insert into [TestPresentationDB3].[dbo].[Dim_Medewerker_Pit3](

)
select 
from [TestIntegrationDB3].dbo.Pit_Medewerker3 pm
inner join dbo.H_Medewerker3 hm
      on     hm.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
left join dbo.S_Medewerker3_nvrtrw s_m_nvrtrw
      on     s_m_nvrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
	   and s_m_nvrtrw.meta_load_date       = pm.nvrtrw_load_date
	   and s_m_nvrtrw.meta_create_time     = pm.nvrtrw_create_time
left join dbo.S_Medewerker3_vrtrw s_m_vrtrw
      on     s_m_vrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
         and s_m_vrtrw.meta_load_date       = pm.vrtrw_load_date
	   and s_m_vrtrw.meta_create_time     = pm.vrtrw_create_time
--order by 1,2,3
