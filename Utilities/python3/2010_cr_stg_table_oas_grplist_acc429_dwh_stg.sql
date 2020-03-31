-- USE [DWH_STG]
-- GO
use [TestStagingDB3];
go

/****** Object:  Table [codafin12].[oas_grplist]    Script Date: 3/26/2020 9:29:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [codafin12].[oas_grplist](
	[cmpcode] [varchar](12) NULL,
	[code] [varchar](72) NULL,
	[elmlevel] [smallint] NULL,
	[lstseqno] [smallint] NULL,
	[grpcode] [varchar](12) NOT NULL,
	[META_LAADDATUM] [datetime] NULL,
	[META_BRON] [varchar](20) NULL,
	[META_GEVALIDEERD] [bit] NULL
) ON [PRIMARY]
GO

ALTER TABLE [codafin12].[oas_grplist] ADD  DEFAULT (getdate()) FOR [META_LAADDATUM]
GO

ALTER TABLE [codafin12].[oas_grplist] ADD  DEFAULT ('codafin12') FOR [META_BRON]
GO

ALTER TABLE [codafin12].[oas_grplist] ADD  DEFAULT ((0)) FOR [META_GEVALIDEERD]
GO

EXEC sys.sp_addextendedproperty @name=N'DW_Kortenaam', @value=N'OasGrplist' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_grplist'
GO

EXEC sys.sp_addextendedproperty @name=N'dw_sleutel', @value=N'cmpcode|code|elmlevel|lstseqno' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_grplist'
GO


