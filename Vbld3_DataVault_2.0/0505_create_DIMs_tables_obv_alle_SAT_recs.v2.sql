-- file: 0505_create_DIMs_tables_obv_alle_SAT_recs.v2.qql
-- functie:  create DIMs met als uitgangspunt dat alle SAT records uit een betreffende SAT tabel
--           geladen worden in de DIMs

use [TestPresentationDB3]
go

-- let op v2

-- verwijder FK tussen FACT en DIM
ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet]
DROP CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Compleet_Dim_Organisatie_Eenheid_Compleet];
GO

-- create DIMs

-- *** Begin Dim_Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Organisatie_Eenheid_Compleet]')
			  AND type in (N'U'))
DROP TABLE [dbo].[Dim_Organisatie_Eenheid_Compleet]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Organisatie_Eenheid_Compleet]')
			     AND type in (N'U'))
BEGIN

--methode1
CREATE TABLE [dbo].[Dim_Organisatie_Eenheid_Compleet](
     -- Pk
	    [H_Organisatie3HashKey] [varchar](32) NOT NULL 
	   ,[meta_load_date] [date] NOT NULL
	   ,[meta_create_time] [time] NOT NULL

     -- Business key
     ,[code] [varchar](25)  NOT NULL

     -- Properties
	   ,[naam] [varchar](80)  NULL

     ,[meta_record_source] [varchar](255) NOT NULL
CONSTRAINT [PK_Dim_Organisatie_Eenheid_Compleet] PRIMARY KEY nonclustered 
(
    [H_Organisatie3HashKey] ASC
   ,[meta_load_date] ASC
   ,[meta_create_time] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


-- *** Begin Dim_Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker_Compleet]')
			  AND type in (N'U'))
DROP TABLE [dbo].[Dim_Medewerker_Compleet]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO


IF NOT EXISTS (SELECT * FROM sys.objects 
               WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker_Compleet]')
			     AND type in (N'U'))


-- methode1
CREATE TABLE [dbo].[Dim_Medewerker_Compleet](
        -- PK
	    [H_Medewerker3Hashkey] [varchar](32) NOT NULL
	   ,[meta_load_date_nvrtrw] [date] NOT NULL
	   ,[meta_create_time_nvrtrw] [time] NOT NULL
	   ,[meta_load_date_vrtrw] [date] NOT NULL
	   ,[meta_create_time_vrtrw] [time] NOT NULL


       -- Business key
       ,[nr] [varchar](6) NOT NULL
 
        -- uit Sat S_Medewerker3_nvrtrw
       ,[hoogste_opleiding] [varchar](20) NULL
       ,[bril_dragend] [char](1) NULL
       ,[schoenmaat] [int] NULL

	    -- uit Sat S_Medewerker3_vrtrw
       ,[voorletters] [varchar](20) NULL
       ,[voorvoegsel] [varchar](10) NULL
       ,[achternaam] [varchar](40) NULL
       ,[geboortedatum] [date]  NULL
       ,[aow_datum] [date] NULL

         -- Meta data
       ,meta_record_source [varchar](255) NOT NULL

        CONSTRAINT [PK_Dim_Medewerker_Compleet] PRIMARY KEY nonclustered 
        (
          [H_Medewerker3Hashkey] ASC
         ,[meta_load_date_nvrtrw] ASC
         ,[meta_create_time_nvrtrw] ASC
         ,[meta_load_date_vrtrw] ASC
         ,[meta_create_time_vrtrw] ASC   
        ) ON [PRIMARY]
)
GO


SET ANSI_PADDING OFF
GO


