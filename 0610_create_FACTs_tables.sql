use [TestPresentationDB]
go

-- create FACTs


-- *** Begin FACT_gepensioneerde_per_OE *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FACT_gepensioneerde_per_OE]') AND type in (N'U'))
DROP TABLE [dbo].[FACT_gepensioneerde_per_OE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FACT_gepensioneerde_per_OE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FACT_gepensioneerde_per_OE](
     [FACT_gepensioneerde_per_OE_key] bigint IDENTITY(1,1) NOT NULL
	,[Organisatie_Eenheid_key] [bigint] NOT NULL 
	,[aantal_gepensioneerden] [bigint]  NOT NULL
	,[meta_record_source] [varchar](255) NOT NULL
	,[meta_load_date] [date] NOT NULL
	,[meta_create_time] [time] NOT NULL
,CONSTRAINT [PK_FACT_gepensioneerde_per_OE] PRIMARY KEY nonclustered 
(
	[FACT_gepensioneerde_per_OE_key] ASC
)
,CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Dim_Organisatie_Eenheid] FOREIGN KEY (Organisatie_Eenheid_key) 
           REFERENCES Dim_Organisatie_Eenheid (Organisatie_Eenheid_key)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO

