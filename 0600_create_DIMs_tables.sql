use [TestPresentationDB]
go

-- create DIMs


-- *** Begin Dim_Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Organisatie_Eenheid]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_Organisatie_Eenheid]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Organisatie_Eenheid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dim_Organisatie_Eenheid](
	   [organisatie_eenheid_key] [bigint] IDENTITY(1,1) NOT NULL 
	  ,[code] [varchar](25)  NOT NULL
	  ,[naam] [varchar](80)  NULL
	  ,[meta_record_source] [varchar](255) NOT NULL
	  ,[meta_load_date] [date] NOT NULL
	  ,[meta_create_time] [time] NOT NULL
CONSTRAINT [PK_Dim_Organisatie_Eenheid] PRIMARY KEY nonclustered 
(
	[organisatie_eenheid_key] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


-- *** Begin Dim_Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_Medewerker]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Dim_Medewerker](
	   [medewerker_key] [bigint] IDENTITY(1,1) NOT NULL
      ,[nr] [varchar](6) NOT NULL
      ,[voorletters] [varchar](20) NULL
      ,[voorvoegsel] [varchar](10) NULL
      ,[achternaam] [varchar](40) NULL
      ,[geboortedatum] [date]  NULL
      ,[aow_datum] [date] NULL
	  ,[meta_record_source] [varchar](255) NOT NULL
	  ,[meta_load_date] [date] NOT NULL
	  ,[meta_create_time] [time] NOT NULL
CONSTRAINT [PK_Dim_Medewerker] PRIMARY KEY nonclustered 
(
	[medewerker_key] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


