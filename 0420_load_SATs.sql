-- vullen sat S_Medewerker en S_Organisatie_Eenheid

-- Artikel over merge statement
-- https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/


use [TestIntegrationDB]
go

MERGE [TestIntegrationDB].[dbo].[S_Medewerker] sm
USING [TestStagingDB].[dbo].[Medewerker] stgm
ON ( sm.H_MedewerkerHashkey =  HASHBYTES('SHA2_256', str(stgm.nr) ) ) -- hash van de business key
WHEN MATCHED
    -- update actie 
    THEN 
	     update
	     set 
             sm.voorletters=stgm.voorletters
            ,sm.voorvoegsel=stgm.voorvoegsel
		    ,sm.achternaam=stgm.achternaam
		    ,sm.geboortedatum=stgm.geboortedatum
		    ,sm.aow_datum=stgm.aow_datum
WHEN NOT MATCHED BY TARGET
     -- insert actie
    THEN
	    insert (
                 [H_MedewerkerHashkey]
                ,[voorletters]
                ,[voorvoegsel]
                ,[achternaam]
                ,[geboortedatum]
                ,[aow_datum]
                ,[meta_record_source]
                ,[meta_load_date]
                ,[meta_create_time]		
		) values(
		   HASHBYTES('SHA2_256', str(stgm.nr))
		  ,stgm.[voorletters]
		  ,stgm.[voorvoegsel]
          ,stgm.[achternaam]
          ,stgm.[geboortedatum]
          ,stgm.[aow_datum]
          ,stgm.[meta_record_source]
          ,stgm.[meta_load_date]
          ,stgm.[meta_create_time]	
		)	
-- geen delete actie
-- als delete actie dcan moet dit niet vergelijken sat met staging maar sat met bron
--WHEN NOT MATCHED BY SOURCE
--    -- delete actie
--    THEN 
--	     NULL
;



-- oud
--select *
--from [TestStagingDB].[dbo].[Medewerker] stgm
---- voer wijziging door obv volgorde van datum en tijd in staging (oudste eerste, nieuweste als laast)
--left outer join [TestIntegrationDB].[dbo].[S_Medewerker] sm
--     on (     sm.H_MedewerkerHashkey =  HASHBYTES('SHA2_256', str(stgm.nr))
--	      AND sm.meta_load_date   IS NULL
--		  AND sm.meta_create_time IS NULL
--         )
--where 1=1
--  and (
--         -- change detection
--            ISNULL(stgm.voorletters, '')   != ISNULL(sm.voorletters, '')
--         OR ISNULL(stgm.voorvoegsel, '')   != ISNULL(sm.voorvoegsel, '')
--		 OR ISNULL(stgm.achternaam, '')    != ISNULL(sm.achternaam, '')
--		 OR ISNULL(stgm.geboortedatum, '') != ISNULL(sm.geboortedatum, '')
--		 OR ISNULL(stgm.aow_datum, '')     != ISNULL(sm.aow_datum, '')
--      )
--order by 
--          stgm.meta_load_date asc
--		 ,stgm.meta_create_time asc
--		 ,stgm.nr asc  -- business key