-- File:  0801_cr_table_pit_medewerker.sql
-- Functie: create pit table voor medewerker  

use [TestIntegrationDB3];
go

-- Ivm performance alle pit tables aanmaken in database TestIntegrationDB3
-- zodat tijdens het laden van de pit tabellen alle data uit selechts 1 database komt
-- en er geen data combineerd wordt uit meerdere databases.


-- *** Begin pit_medewerker *** --
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pit_Medewerker3]') AND type in (N'U'))
DROP TABLE [dbo].[Pit_Medewerker3]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pit_medewerker3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Pit_Medewerker3](
     -- tbv PK
	 [H_Medewerker3Hashkey] [varchar](32) NOT NULL  -- PK kolom
    ,[pit_load_date] [date] NOT NULL				-- PK kolom
	,[pit_load_time] [time] NOT NULL				-- PK kolom

	 -- uit SAT nvrtrw
    ,[nvrtrw_load_date] [date] NOT NULL
	,[nvrtrw_create_time] [time] NOT NULL
	 -- uit SAT vrtrw
    ,[vrtrw_load_date] [date] NOT NULL
	,[vrtrw_create_time] [time] NOT NULL

	,meta_record_source [varchar](255) NOT NULL
    CONSTRAINT [PK_pit_medewerker3] PRIMARY KEY nonclustered 
    (
	  [H_Medewerker3Hashkey] ASC
	 ,[pit_load_date] ASC
	 ,[pit_load_time] ASC
	 -- nodig om uniek te maken
    ,[nvrtrw_load_date]  ASC
	,[nvrtrw_create_time] ASC
	 -- uit SAT vrtrw
    ,[vrtrw_load_date] ASC
    ,[vrtrw_create_time] ASC
    ) ON [PRIMARY]
) ON [PRIMARY]
END
GO