-- USE [DWH_STG]
-- GO
use [TestStagingDB3];
go


/****** Object:  Table [codafin12].[oas_element]    Script Date: 3/26/2020 9:23:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [codafin12].[oas_element](
	[cmpcode] [varchar](12) NULL,
	[cmpcode_cs] [int] NULL,
	[code] [varchar](72) NULL,
	[code_cs] [int] NULL,
	[elmlevel] [smallint] NULL,
	[elmlevel_cs] [int] NULL,
	[indirectcode] [varchar](72) NULL,
	[tstamp] [smallint] NULL,
	[name] [varchar](36) NULL,
	[sname] [varchar](20) NULL,
	[cur] [varchar](12) NULL,
	[tax] [varchar](12) NULL,
	[accounttype] [smallint] NULL,
	[statuser] [char](1) NULL,
	[statpay] [smallint] NULL,
	[statrec] [smallint] NULL,
	[descr] [smallint] NULL,
	[matchable] [smallint] NULL,
	[statpayint] [int] NULL,
	[summary] [smallint] NULL,
	[split] [smallint] NULL,
	[settle] [varchar](79) NULL,
	[paper] [smallint] NULL,
	[elec] [smallint] NULL,
	[subanal] [smallint] NULL,
	[taxrepesl] [smallint] NULL,
	[taxrepintra] [smallint] NULL,
	[crliminforce] [smallint] NULL,
	[crlim] [money] NULL,
	[crlim_dp] [smallint] NULL,
	[taxmethod] [smallint] NULL,
	[terms] [varchar](4) NULL,
	[keepturn] [smallint] NULL,
	[ten99] [smallint] NULL,
	[custsuppacc] [smallint] NULL,
	[discenable] [smallint] NULL,
	[forcedisperse] [smallint] NULL,
	[enablepay] [smallint] NULL,
	[paymode] [varchar](12) NULL,
	[priority] [smallint] NULL,
	[medcode] [varchar](12) NULL,
	[tag] [smallint] NULL,
	[qty1_used] [smallint] NULL,
	[qty1_title] [varchar](36) NULL,
	[qty1_mand] [smallint] NULL,
	[qty1_balcode] [varchar](12) NULL,
	[qty1_dp] [smallint] NULL,
	[qty2_used] [smallint] NULL,
	[qty2_title] [varchar](36) NULL,
	[qty2_mand] [smallint] NULL,
	[qty2_balcode] [varchar](12) NULL,
	[qty2_dp] [smallint] NULL,
	[qty3_used] [smallint] NULL,
	[qty3_title] [varchar](36) NULL,
	[qty3_mand] [smallint] NULL,
	[qty3_balcode] [varchar](12) NULL,
	[qty3_dp] [smallint] NULL,
	[qty4_used] [smallint] NULL,
	[qty4_title] [varchar](36) NULL,
	[qty4_mand] [smallint] NULL,
	[qty4_balcode] [varchar](12) NULL,
	[qty4_dp] [smallint] NULL,
	[adddate] [datetime] NULL,
	[moddate] [datetime] NULL,
	[deldate] [datetime] NULL,
	[usrname] [varchar](12) NULL,
	[accountsummary] [varchar](12) NULL,
	[crlimdate] [datetime] NULL,
	[crlimcurr] [smallint] NULL,
	[elmstat] [varchar](12) NULL,
	[sic] [varchar](36) NULL,
	[crmanager] [varchar](12) NULL,
	[crrating] [varchar](36) NULL,
	[crratingdate] [datetime] NULL,
	[crref] [varchar](36) NULL,
	[cragency] [varchar](36) NULL,
	[dateaccopened] [datetime] NULL,
	[paymentindex] [varchar](36) NULL,
	[taxadjustment] [smallint] NULL,
	[matchtopo] [smallint] NULL,
	[extval] [varchar](8) NULL,
	[arcpaid] [smallint] NULL,
	[arcrecon] [smallint] NULL,
	[ten99code] [varchar](12) NULL,
	[subslevel] [smallint] NULL,
	[subselm] [varchar](72) NULL,
	[temporaryelm] [smallint] NULL,
	[maxtemporaryid] [int] NULL,
	[allowtaxnum] [smallint] NULL,
	[allowlangcode] [smallint] NULL,
	[allowctycode] [smallint] NULL,
	[forceterms] [smallint] NULL,
	[forcetaxnum] [smallint] NULL,
	[forceaddress] [smallint] NULL,
	[force1099] [smallint] NULL,
	[startyear] [smallint] NULL,
	[startperiod] [smallint] NULL,
	[endyear] [smallint] NULL,
	[endperiod] [smallint] NULL,
	[statmemo] [varchar](12) NULL,
	[balancingacc] [varchar](79) NULL,
	[catcode] [varchar](12) NULL,
	[assetelement] [smallint] NULL,
	[extcode] [varchar](12) NULL,
	[extconfig] [smallint] NULL,
	[procorders] [varchar](12) NULL,
	[procreq] [varchar](12) NULL,
	[repcode1] [varchar](12) NULL,
	[repcode2] [varchar](12) NULL,
	[repcode3] [varchar](12) NULL,
	[punchoutcode] [varchar](12) NULL,
	[punchouturl] [varchar](255) NULL,
	[punchoutdomain] [varchar](32) NULL,
	[punchoutuser] [varchar](32) NULL,
	[punchoutpasswd] [varchar](32) NULL,
	[punchoutidcode] [varchar](24) NULL,
	[punchoutenc] [smallint] NULL,
	[punchoutmktplace] [smallint] NULL,
	[custsuppaccext] [smallint] NULL,
	[autoreceipt] [smallint] NULL,
	[procstatus] [smallint] NULL,
	[tolerancecode] [varchar](12) NULL,
	[matchingoffset] [smallint] NULL,
	[proctranslimit] [money] NULL,
	[proctranslimit_dp] [smallint] NULL,
	[proccalloffs] [varchar](12) NULL,
	[procgrns] [varchar](12) NULL,
	[procreturns] [varchar](12) NULL,
	[procemailsal] [varchar](255) NULL,
	[procemailsub] [varchar](255) NULL,
	[euvatcode] [varchar](12) NULL,
	[longname] [varchar](240) NOT NULL,
	[META_LAADDATUM] [datetime] NULL,
	[META_BRON] [varchar](20) NULL,
	[META_GEVALIDEERD] [bit] NULL
) ON [PRIMARY]
GO

ALTER TABLE [codafin12].[oas_element] ADD  DEFAULT (getdate()) FOR [META_LAADDATUM]
GO

ALTER TABLE [codafin12].[oas_element] ADD  DEFAULT ('codafin12') FOR [META_BRON]
GO

ALTER TABLE [codafin12].[oas_element] ADD  DEFAULT ((0)) FOR [META_GEVALIDEERD]
GO

EXEC sys.sp_addextendedproperty @name=N'DW_Kortenaam', @value=N'OasElement' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_element'
GO

EXEC sys.sp_addextendedproperty @name=N'dw_sleutel', @value=N'cmpcode|code|elmlevel' , @level0type=N'SCHEMA',@level0name=N'codafin12', @level1type=N'TABLE',@level1name=N'oas_element'
GO


