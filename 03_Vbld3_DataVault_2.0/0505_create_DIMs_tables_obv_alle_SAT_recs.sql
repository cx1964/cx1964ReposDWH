-- file: 0505_create_DIMs_tables_obv_alle_SAT_recs.qql
-- functie:  create DIMs met als uitgangspunt dat alle SAT records uit een betreffende SAT tabel
--           geladen worden in de DIMs

use [TestPresentationDB3]
go


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
	   [H_Organisatie3HashKey] [varchar](32) NOT NULL 
	  ,[meta_load_date] [date] NOT NULL
	  ,[meta_create_time] [time] NOT NULL

      ,[code] [varchar](25)  NOT NULL
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
BEGIN

-- methode1
CREATE TABLE [dbo].[Dim_Medewerker_Compleet](
	    [H_Medewerker3Hashkey] [varchar](32) NOT NULL
	   ,[meta_load_date] [date] NOT NULL
	   ,[meta_create_time] [time] NOT NULL

       ,[nr] [varchar](6) NOT NULL
       ,[voorletters] [varchar](20) NULL
       ,[voorvoegsel] [varchar](10) NULL
       ,[achternaam] [varchar](40) NULL
       ,[geboortedatum] [date]  NULL
       ,[aow_datum] [date] NULL

      ,[meta_record_source] [varchar](255) NOT NULL
CONSTRAINT [PK_Dim_Medewerker_Compleet] PRIMARY KEY nonclustered 
(
    [H_Medewerker3Hashkey] ASC
   ,[meta_load_date] ASC
   ,[meta_create_time] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


