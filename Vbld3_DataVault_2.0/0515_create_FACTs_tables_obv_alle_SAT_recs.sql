-- Filenaam: 0515_create_FACTs_tables_obv_alle_SAT_recs.sql
-- Functie:  Table definitie Fact die gebruik gaat maken van alle SAT records

use [TestPresentationDB3]
go

-- create FACTs


-- *** Begin FACT_gepensioneerde_per_OE *** --
IF  EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[FACT_gepensioneerde_per_OE_Compleet]')
			  AND type in (N'U'))
DROP TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[FACT_gepensioneerde_per_OE_Compleet]')
			     AND type in (N'U'))
BEGIN

-- Methode1 obv hashkeys
CREATE TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet](
     [FACT_gepensioneerde_per_OE_Compleet_key] bigint IDENTITY(1,1) NOT NULL

     -- FK naar Dim_Organisatie_Eenheid_Compleet
    ,[H_Organisatie3HashKey] [varchar](32) NOT NULL 
    ,[meta_load_date] [date] NOT NULL
    ,[meta_create_time] [time] NOT NULL

     -- Meet waarde
    ,[aantal_gepensioneerden] [bigint]  NOT NULL
    ,[meta_record_source] [varchar](255) NOT NULL

,CONSTRAINT [PK_FACT_gepensioneerde_per_OE_Compleet] PRIMARY KEY nonclustered 
(
	[FACT_gepensioneerde_per_OE_Compleet_key] ASC
)
,CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Compleet_Dim_Organisatie_Eenheid_Compleet]
            FOREIGN KEY (
             [H_Organisatie3HashKey]
            ,[meta_load_date]
            ,[meta_create_time]
             )
            REFERENCES Dim_Organisatie_Eenheid_Compleet (
             [H_Organisatie3HashKey]
            ,[meta_load_date]
            ,[meta_create_time]
            )
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


