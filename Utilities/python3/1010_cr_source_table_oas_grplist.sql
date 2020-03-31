use [TestSourceDB3];
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

drop table  [codafin12].[oas_grplist];
go

CREATE TABLE [codafin12].[oas_grplist](
	[cmpcode] [varchar](12) NULL,
	[code] [varchar](72) NULL,
	[elmlevel] [smallint] NULL,
	[lstseqno] [smallint] NULL,
	[grpcode] [varchar](12) NOT NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'DW_Kortenaam', @value=N'OasGrplist' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_grplist'
GO

EXEC sys.sp_addextendedproperty @name=N'dw_sleutel', @value=N'cmpcode|code|elmlevel|lstseqno' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_grplist'
GO


