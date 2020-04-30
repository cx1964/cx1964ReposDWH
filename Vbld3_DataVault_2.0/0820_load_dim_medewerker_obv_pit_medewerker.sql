-- File: 0820_load_dim_medewerker_obv_pit_medewerker.sql
-- Functie: load dim_medewerker obv van pit tabel pit_medewerker

use TestIntegrationDB3;
go


insert into [TestPresentationDB3].[dbo].[Dim_Medewerker_Pit](
	    [H_Medewerker3Hashkey]
	   ,[meta_load_date]
	   ,[meta_create_time]

	   ,[nr]

	   -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding]
       ,[bril_dragend]
       ,[schoenmaat]

	   -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters]
       ,[voorvoegsel]
       ,[achternaam]
       ,[geboortedatum]
       ,[aow_datum]

      ,[meta_record_source]
)
select pm.*
      ,s_m_nvrtrw.*
	  ,s_m_vrtrw.*
from dbo.Pit_Medewerker pm
inner join dbo.S_Medewerker3_nvrtrw s_m_nvrtrw
      on     s_m_nvrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
	     and s_m_nvrtrw.meta_load_date       = pm.nvrtrw_load_date
		 and s_m_nvrtrw.meta_create_time     = pm.nvrtrw_create_time
inner join dbo.S_Medewerker3_vrtrw s_m_vrtrw
      on     s_m_vrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
	     and s_m_vrtrw.meta_load_date       = pm.vrtrw_load_date
		 and s_m_vrtrw.meta_create_time     = pm.vrtrw_create_time
-- order by 1,2
