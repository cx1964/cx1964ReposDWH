/* Filenaam   : 9000_db_backup_IntegrationDB.sql
 * Functie    : SQL2016 Database backup van IntegrationDB database
 *              
 * Opmerkingen: 
 *
 * --------- history ---------------------
 * v.0.0.0   2020-01-22   C.X. la Fontaine
 */

use master;
go

BACKUP DATABASE [TestSourceDB]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestSourceDB_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'SourceDB full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO



BACKUP DATABASE [TestIntegrationDB]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestIntegrationDB_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'TestIntegrationDB full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO


BACKUP DATABASE [TestPresentationDB]
TO  DISK = 'C:\tmp\cx1964ReposDWH_ETL_DV_DataMart\TestPresentationDB_20200130.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'PresentationDB full Database Backup 20200130',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO

