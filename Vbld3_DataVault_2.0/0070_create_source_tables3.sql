-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15

use [TestSourceDB3]
go

-- *** Begin Organisatie_Eenheid3 *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Organisatie_Eenheid3]') AND type in (N'U'))
DROP TABLE [dbo].[Organisatie_Eenheid3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Organisatie_Eenheid3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Organisatie_Eenheid3](
	 [id] [int] NOT NULL IDENTITY(1,1)
	,[code] [varchar](25) NOT NULL
	,[naam] [varchar](80) NOT NULL

CONSTRAINT [PK_Organisatie_Eenheid2] PRIMARY KEY nonclustered 
(
	[id] ASC
) ON [PRIMARY],

CONSTRAINT UK_Organisatie_EenheidCode3 unique nonclustered
(
  Code
)

) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

-- *** Begin Medewerker3 *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Medewerker3]') AND type in (N'U'))
DROP TABLE [dbo].[Medewerker3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Medewerker3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Medewerker3](
    -- surrogate key
	  [id] [int] NOT NULL IDENTITY(1,1)
    -- business key
   ,[nr] [varchar](6) NOT NULL
    -- properties
    -- Privacy gevoelige gegevens
   ,[voorletters] [varchar](20) NOT NULL
   ,[voorvoegsel] [varchar](10) NULL
   ,[achternaam] [varchar](40) NOT NULL
   ,[geboortedatum] [date] not null
   ,[aow_datum] [date] not null
   ,[werkt_voor_org_eenheid] [int] not null
   -- Niet privacy gegevens
   ,[hoogste_opleiding] [varchar](20) not null
   ,[bril_dragend] [char](1) not null
   ,[schoenmaat] [int] not null

CONSTRAINT [PK_Medewerker3] PRIMARY KEY nonclustered
(
	[id] ASC
) ON [PRIMARY],

CONSTRAINT UK_MedewerkerNr3 unique nonclustered
(
  Nr
),

CONSTRAINT FK_Medewerker_Organisatie_Eenheid3 FOREIGN KEY (werkt_voor_org_eenheid)
           REFERENCES Organisatie_Eenheid3 (id)


) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO
-- *** Einde Medewerker3 *** --

