-- File: 0820_load_dim_medewerker_obv_pit_medewerker.sql
-- Functie: load dim_medewerker obv van pit tabel pit_medewerker

use TestIntegrationDB3;
go

-- ToDo
-- Oplossen probleem dat Dim records niet uniek zijn

insert into [TestPresentationDB3].[dbo].[Dim_Medewerker_Pit](
  [H_Medewerker3Hashkey]
 ,[meta_load_date]
 ,[meta_create_time]
 ,[nvrtrw_change_hashkey] -- extra toegevoegd
 ,[vrtrw_change_hashkey] -- extra toegevoegd

 ,[nr]

   -- uit Sat S_Medewerker3_nvrtrw
 ,[meta_load_date_nvrtrw]
 ,[meta_create_time_nvrtrw]
 ,[hoogste_opleiding]
 ,[bril_dragend]
 ,[schoenmaat]

  -- uit Sat S_Medewerker3_vrtrw
 ,[meta_load_date_vrtrw]
 ,[meta_create_time_vrtrw]
 ,[voorletters]
 ,[voorvoegsel]
 ,[achternaam]
 ,[geboortedatum]
 ,[aow_datum]

 ,[meta_record_source]
)
select 
	    hm.[H_Medewerker3Hashkey]
	   ,hm.[meta_load_date]
	   ,hm.[meta_create_time]
	   ,s_m_nvrtrw.meta_change_hashkey as nvrtrw_change_hashkey -- extra toegevoegd
	   ,s_m_vrtrw.meta_change_hashkey as vrtrw_change_hashkey -- extra toegevoegd

	   ,hm.nr

        -- uit Sat S_Medewerker3_nvrtrw
	   ,s_m_nvrtrw.meta_load_date      as meta_load_date_nvrtrw -- extra toegevoegd
	   ,s_m_nvrtrw.meta_create_time    as meta_create_time_nvrtrw -- extra toegevoegd

       ,s_m_nvrtrw.[hoogste_opleiding]
       ,s_m_nvrtrw.[bril_dragend]
       ,s_m_nvrtrw.[schoenmaat]

        -- uit Sat S_Medewerker3_vrtrw
	   ,s_m_vrtrw.meta_load_date       as meta_load_date_vrtrw  -- extra toegevoegd
	   ,s_m_vrtrw.meta_create_time     as meta_create_time_vrtrw -- extra toegevoegd
		
       ,s_m_vrtrw.[voorletters]
       ,s_m_vrtrw.[voorvoegsel]
       ,s_m_vrtrw.[achternaam]
       ,s_m_vrtrw.[geboortedatum]
       ,s_m_vrtrw.[aow_datum]

        -- keuze: neem source over uit de pit table over
       ,hm.[meta_record_source]
from [TestIntegrationDB3].dbo.Pit_Medewerker pm
inner join dbo.H_Medewerker3 hm
      on     hm.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
left join dbo.S_Medewerker3_nvrtrw s_m_nvrtrw
      on     s_m_nvrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
	     and s_m_nvrtrw.meta_change_hashkey  = pm.nvrtrw_change_Hashkey
	  --   and s_m_nvrtrw.meta_load_date       = pm.nvrtrw_load_date
		 --and s_m_nvrtrw.meta_create_time     = pm.nvrtrw_create_time
left join dbo.S_Medewerker3_vrtrw s_m_vrtrw
      on     s_m_vrtrw.H_Medewerker3Hashkey = pm.H_Medewerker3Hashkey
	     and s_m_vrtrw.meta_change_hashkey  = pm.vrtrw_change_Hashkey
	  --   and s_m_vrtrw.meta_load_date       = pm.vrtrw_load_date
		 --and s_m_vrtrw.meta_create_time     = pm.vrtrw_create_time
order by 1,2,3
