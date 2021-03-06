-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15

use [TestIntegrationDB3]
go

-- create Hubs


-- *** Begin Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[H_Organisatie_Eenheid3]') AND type in (N'U'))
DROP TABLE [dbo].[H_Organisatie_Eenheid3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[H_Organisatie_Eenheid3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[H_Organisatie_Eenheid3](
	 [h_Organisatie_Eenheid3Hashkey] [varchar](32) NOT NULL  --tbv hashkey op kolom code
	,[code] [varchar](25)  NOT NULL
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
 CONSTRAINT [PK_H_Organisatie_Eenheid3] PRIMARY KEY nonclustered 
(
	 [H_Organisatie_Eenheid3Hashkey] ASC
) ON [PRIMARY],
CONSTRAINT UK_H_Organisatie_EenheidCode3 unique nonclustered
(
  Code
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[H_Medewerker3]') AND type in (N'U'))
DROP TABLE [dbo].[H_Medewerker3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[H_Medewerker3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[H_Medewerker3](
	 [H_Medewerker3Hashkey] [varchar](32) NOT NULL
    ,[nr] [varchar](6) NOT NULL
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
 CONSTRAINT [PK_H_Medewerker3] PRIMARY KEY nonclustered 
(
	[H_Medewerker3Hashkey] ASC
) ON [PRIMARY],
CONSTRAINT UK_H_MedewerkerNr3 unique nonclustered
(
  Nr
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


