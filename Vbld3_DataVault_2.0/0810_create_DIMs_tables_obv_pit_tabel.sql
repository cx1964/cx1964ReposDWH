-- file: 0810_create_DIMs_tables_obv_pit_tabel.sql
-- functie:  create DIMs obv van pit tabellen

use [TestPresentationDB3]
go


-- verwijder FK tussen FACT en DIM
-- even uitzetten
--ALTER TABLE [dbo].[FACT_gepensioneerde_per_OE_Compleet]
--DROP CONSTRAINT [FK_FACT_gepensioneerde_per_OE_Compleet_Dim_Organisatie_Eenheid_Compleet];
--GO

-- create DIMs

-- *** Begin Dim_Organisatie_Eenheid *** --
-- Nog definitie voor Dim_Organisatie_Eenheid_Pit


-- *** Begin Dim_Medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker_Pit]')
			  AND type in (N'U'))
DROP TABLE [dbo].[Dim_Medewerker_Pit]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO


IF NOT EXISTS (SELECT * FROM sys.objects 
               WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Medewerker_Pit]')
			     AND type in (N'U'))
BEGIN

-- methode1
CREATE TABLE [dbo].[Dim_Medewerker_Pit](
	    [H_Medewerker3Hashkey] [varchar](32) NOT NULL
	   ,[meta_load_date] [date] NOT NULL
	   ,[meta_create_time] [time] NOT NULL
	   ,[nvrtrw_change_hashkey] [varchar](32) NOT NULL
	   ,[vrtrw_change_hashkey] [varchar](32) NOT NULL

	   ,[nr] [varchar](6) NOT NULL

	   -- uit Sat S_Medewerker3_nvrtrw
	   ,meta_load_date_nvrtrw [date] NOT NULL
	   ,meta_create_time_nvrtrw [time] NOT NULL
       ,[hoogste_opleiding] [varchar](20) NULL
       ,[bril_dragend] [char](1) NULL
       ,[schoenmaat] [int] NULL

	   -- uit Sat S_Medewerker3_vrtrw
	   ,meta_load_date_vrtrw [date] NOT NULL
	   ,meta_create_time_vrtrw [time] NOT NULL
       ,[voorletters] [varchar](20) NULL
       ,[voorvoegsel] [varchar](10) NULL
       ,[achternaam] [varchar](40) NULL
       ,[geboortedatum] [date]  NULL
       ,[aow_datum] [date] NULL

      ,[meta_record_source] [varchar](255) NOT NULL
CONSTRAINT [PK_Dim_Medewerker_Pit] PRIMARY KEY nonclustered 
(
    [H_Medewerker3Hashkey] ASC
   ,[meta_load_date] ASC
   ,[meta_create_time] ASC
   ,[nvrtrw_change_hashkey] ASC
   ,[vrtrw_change_hashkey] ASC
)
) ON [PRIMARY]
END
GO


SET ANSI_PADDING OFF
GO


