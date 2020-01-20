use [myTestDB]
go

-- create Sats


-- *** Begin Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid]') AND type in (N'U'))
DROP TABLE [dbo].[S_Organisatie_Eenheid]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Organisatie_Eenheid](
	 [H_Organisatie_EenheidHashkey] [varchar](32) NOT NULL 
	,[Naam] [varchar](80)  NOT NULL
	,[meta_record_source] [varchar](255) NULL
	,[meta_load_date] [date] NULL
	,[meta_create_time] [time] NULL
 CONSTRAINT [PK_S_Organisatie_Eenheid] PRIMARY KEY CLUSTERED 
(
	[H_Organisatie_EenheidHashkey] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker]') AND type in (N'U'))
DROP TABLE [dbo].[S_Medewerker]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Medewerker](
	 [H_MedewerkerHashkey] [varchar](32) NOT NULL
    ,[voorletters] [varchar](20) NOT NULL
    ,[voorvoegsel] [varchar](10) NULL
    ,[achternaam] [varchar](40) NOT NULL
    ,[geboortedatum] [date] not null
    ,[aow_datum] [date] not null
	,[meta_record_source] [varchar](255) NULL
	,[meta_load_date] [date] NULL
	,[meta_create_time] [time] NULL
 CONSTRAINT [PK_s_Medewerker] PRIMARY KEY CLUSTERED 
(
	[H_MedewerkerHashkey] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


