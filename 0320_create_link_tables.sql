-- Documentatie clustered en nonclusterd indexes
-- Zie https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15

use [TestIntegrationDB]
go

-- create Links


-- *** Begin L_Medewerker_Organisatie_Eenheid *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[L_Medewerker_Organisatie_Eenheid]') AND type in (N'U'))
DROP TABLE [dbo].[L_Medewerker_Organisatie_Eenheid]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[L_Medewerker_Organisatie_Eenheid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[L_Medewerker_Organisatie_Eenheid](
	 [L_Medewerker_Organisatie_EenheidHashkey] [varchar](32) NOT NULL
	,[H_MedewerkerHashkey] [varchar](32) NOT NULL 	
	,[H_Organisatie_EenheidHashkey] [varchar](32) NOT NULL 
	,[meta_record_source] [varchar](255) NULL
	,[meta_load_date] [date] NULL
	,[meta_create_time] [time] NULL
 CONSTRAINT [PK_L_Organisatie_Eenheid] PRIMARY KEY nonclustered 
(
	[L_Medewerker_Organisatie_EenheidHashkey] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

