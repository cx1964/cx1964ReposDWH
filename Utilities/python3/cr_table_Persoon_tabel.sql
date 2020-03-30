USE [TestSourceDB3]
GO

/****** Object:  Table [dbo].[Persoon]    Script Date: 29-3-2020 14:13:42 ******/
DROP TABLE [dbo].[Persoon]
GO

/****** Object:  Table [dbo].[Persoon]    Script Date: 29-3-2020 14:13:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Persoon](
	[id]			[varchar](3)	NOT NULL,
	[voorletters]	[varchar](15)	NOT NULL,
	[achternaam]	[varchar](30)	NOT NULL,
	[geboortedatum]	[date]			NOT NULL
) ON [PRIMARY]
GO



