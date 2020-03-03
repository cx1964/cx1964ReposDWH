/* Filenaam   : 9000_db_backup_IntegrationDB2.sql
 * Functie    : SQL2016 Database backup van IntegrationDB database
 *              
 * Opmerkingen: 
 *
 * --------- history ---------------------
 * v.0.0.0   2020-01-22   C.X. la Fontaine
 */

use master;
go

BACKUP DATABASE [TestSourceDB2]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestSourceDB2_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'SourceDB2 full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO



BACKUP DATABASE [TestIntegrationDB2]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestIntegrationDB2_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'TestIntegrationDB2 full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO


BACKUP DATABASE [TestPresentationDB2]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestPresentationDB2_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'PresentationDB2 full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO

