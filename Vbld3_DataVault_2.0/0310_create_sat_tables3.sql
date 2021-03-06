-- File: 0310_create_sat_tables3.sql
-- Documentatie mbt gebruik van FKs op SATs
-- zie : https://danlinstedt.com/allposts/datavaultcat/foreign-keys-in-satellites/
-- Dwz doe het niet!

-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15

-- 20200506 Toevoeging kolom meta_change_Hashkey in de SATs tbv het verwerken van history in DIMs en FACTs van DataMart
--          zodat een HUB meerdere SATs kan hebben  


use [TestIntegrationDB3]
go

-- create Sats


-- *** Begin Organisatie_Eenheid2 *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid3]') AND type in (N'U'))
DROP TABLE [dbo].[S_Organisatie_Eenheid3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Organisatie_Eenheid3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Organisatie_Eenheid3](
	 [H_Organisatie_Eenheid3Hashkey] [varchar](32) NOT NULL

	 -- Properties
	,[Naam] [varchar](80)  NOT NULL

	-- Meta gegevens
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
	-- DataVault 2.0 => alleen INSERTs en geen updates => geen END Date en END Time
	--,[meta_load_end_date] [date] NOT NULL
	--,[meta_create_end_time] [time] NOT NULL
	--,[meta_IsCurrent] int NOT NULL -- onbekend of nog nodig
	,meta_change_Hashkey [varchar](32) NOT NULL
 CONSTRAINT [PK_S_Organisatie_Eenheid3] PRIMARY KEY nonclustered 
(
	[H_Organisatie_Eenheid3Hashkey] ASC
   ,[meta_load_date]
   ,[meta_create_time] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker *** --

-- 2 SATs voor medewerker: Vertrouwelijk (vrtrw) en niet_vertrouwelijk (nvrtrw)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker3_vrtrw]') AND type in (N'U'))
DROP TABLE [dbo].[S_Medewerker3_vrtrw]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker3_vrtrw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Medewerker3_vrtrw](
	 [H_Medewerker3Hashkey] [varchar](32) NOT NULL
    
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
	-- DataVault 2.0 => alleen INSERTs en geen updates => geen END Date en END Time
	--,[meta_load_end_date] [date] NOT NULL
	--,[meta_create_end_time] [time] NOT NULL
	--,[meta_IsCurrent] int NOT NULL -- onbekend of nog nodig
	,meta_change_Hashkey [varchar](32) NOT NULL
 CONSTRAINT [PK_S_Medewerker3_vrtrw] PRIMARY KEY nonclustered 
(
	[H_Medewerker3Hashkey] ASC
   ,[meta_load_date] ASC	
   ,[meta_create_time] ASC
)
) ON [PRIMARY]
END
GO

-- Niet vertrouwelijk 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker3_nvrtrw]') AND type in (N'U'))
DROP TABLE [dbo].[S_Medewerker3_nvrtrw]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[S_Medewerker3_nvrtrw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[S_Medewerker3_nvrtrw](
	 [H_Medewerker3Hashkey] [varchar](32) NOT NULL

	 -- Properties
    ,[hoogste_opleiding] [varchar](20) null
    ,[bril_dragend] [char](1) null
    ,[schoenmaat] [int] null
    
	-- Meta gegevens
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
	-- DataVault 2.0 => alleen INSERTs en geen updates => geen END Date en END Time
	--,[meta_load_end_date] [date] NOT NULL
	--,[meta_create_end_time] [time] NOT NULL
	--,[meta_IsCurrent] int NOT NULL -- onbekend of nog nodig
	,meta_change_Hashkey [varchar](32) NOT NULL
 CONSTRAINT [PK_S_Medewerker3_nvrtrw] PRIMARY KEY nonclustered 
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
