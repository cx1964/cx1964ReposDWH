-- Staging tabellen zijn een 1:1 copy van de source tabellen
-- Staging tabellen bevatten geen FKs 

-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15

use [TestStagingDB]
go

-- *** Begin Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Organisatie_Eenheid]') AND type in (N'U'))
DROP TABLE [dbo].[Organisatie_Eenheid]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Organisatie_Eenheid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Organisatie_Eenheid](
     -- surrogate key	
	 [id] [int] NULL 

	 -- business key	
	,[code] [varchar](25) NULL

    -- properties
	,[naam] [varchar](80) NULL

    -- Meta gegevens
    ,[meta_record_source] [varchar](255) NULL
	,[meta_load_date] [date] NULL
	,[meta_create_time] [time] NULL
)
END
GO

SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Medewerker]') AND type in (N'U'))
DROP TABLE [dbo].[Medewerker]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Medewerker]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Medewerker](
    -- surrogate key	
	[id] [int] NULL
    -- business key	
   ,[nr] [varchar](6) NULL

   -- properties
   -- Privacy gevoelige gegevens
   ,[voorletters] [varchar](20) NULL
   ,[voorvoegsel] [varchar](10) NULL
   ,[achternaam] [varchar](40) NOT NULL
   ,[geboortedatum] [date] null
   ,[aow_datum] [date] null
   ,[werkt_voor_org_eenheid] [int] null

    -- Niet privacy gegevens
   ,[hoogste_opleiding] [varchar](20) null
   ,[bril_dragend] [char](1) null
   ,[schoenmaat] [int] null
   
   -- Meta gegevens
	,[meta_record_source] [varchar](255) NULL
 	,[meta_load_date] [date] NULL
   ,[meta_create_time] [time] NULL
)
END
GO

SET ANSI_PADDING OFF
GO
-- *** Einde Medewerker *** --

