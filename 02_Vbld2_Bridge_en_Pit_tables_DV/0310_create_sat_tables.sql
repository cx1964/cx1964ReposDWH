-- Documentatie mbt gebruik van FKs op SATs
-- zie : https://danlinstedt.com/allposts/datavaultcat/foreign-keys-in-satellites/
-- Dwz doe het niet!

-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15


use [TestIntegrationDB2]
go

-- create Sats


-- *** Begin Organisatie_Eenheid2 *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid2]') AND type in (N'U'))
DROP TABLE [dbo].[S_Organisatie_Eenheid2]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Organisatie_Eenheid2](
	 [H_Organisatie_Eenheid2Hashkey] [varchar](32) NOT NULL

	 -- Properties
	,[Naam] [varchar](80)  NOT NULL

	-- Meta gegevens
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
	,[meta_load_end_date] [date] NOT NULL
	,[meta_create_end_time] [time] NOT NULL
	,[meta_IsCurrent] int NOT NULL
 CONSTRAINT [PK_S_Organisatie_Eenheid2] PRIMARY KEY nonclustered 
(
	[H_Organisatie_Eenheid2Hashkey] ASC
   ,[meta_create_time] ASC
   ,[meta_load_end_date] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker *** --

-- 2 SATs voor medewerker: Vertrouwelijk (vrtrw) en niet_vertrouwelijk (nvrtrw)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker2_vrtrw]') AND type in (N'U'))
DROP TABLE [dbo].[S_Medewerker2_vrtrw]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker2_vrtrw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Medewerker2_vrtrw](
	 [H_Medewerker2Hashkey] [varchar](32) NOT NULL
    
	 -- Properties
	,[voorletters] [varchar](20) NOT NULL
    ,[voorvoegsel] [varchar](10) NULL
    ,[achternaam] [varchar](40) NOT NULL
    ,[geboortedatum] [date] not null
    ,[aow_datum] [date] not null

	-- Meta gegevens
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
	,[meta_load_end_date] [date] NOT NULL
	,[meta_create_end_time] [time] NOT NULL
	,[meta_IsCurrent] int NOT NULL
 CONSTRAINT [PK_S_Medewerker2_vrtrw] PRIMARY KEY nonclustered 
(
	[H_Medewerker2Hashkey] ASC
   ,[meta_create_time] ASC
   ,[meta_load_end_date] ASC
)
) ON [PRIMARY]
END
GO

-- Niet vertrouwelijk 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker2_nvrtrw]') AND type in (N'U'))
DROP TABLE [dbo].[S_Medewerker2_nvrtrw]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker2_nvrtrw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Medewerker2_nvrtrw](
	 [H_Medewerker2Hashkey] [varchar](32) NOT NULL

	 -- Properties
    ,[hoogste_opleiding] [varchar](20) null
    ,[bril_dragend] [char](1) null
    ,[schoenmaat] [int] null
    
	-- Meta gegevens
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
	,[meta_load_end_date] [date] NOT NULL
	,[meta_create_end_time] [time] NOT NULL
	,[meta_IsCurrent] int NOT NULL
 CONSTRAINT [PK_S_Medewerker2_nvrtrw] PRIMARY KEY nonclustered 
(
	[H_Medewerker2Hashkey] ASC
   ,[meta_create_time] ASC
   ,[meta_load_end_date] ASC
)
) ON [PRIMARY]
END
GO



SET ANSI_PADDING OFF
GO


