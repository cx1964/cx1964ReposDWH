/* Filenaam   : 9000_db_backup_IntegrationDB3.sql
 * Functie    : SQL2016 Database backup van IntegrationDB3 database
 *              
 * Opmerkingen: 
 *
 * --------- history ---------------------
 * v.0.0.0   2020-03-26   C.X. la Fontaine
 */

use master;
go

BACKUP DATABASE [TestSourceDB3]
TO  DISK = 'C:\tmp\cx1964ReposDWH\TestSourceDB3_20200326.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'SourceDB3 full Database Backup 20200326',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO



BACKUP DATABASE [TestIntegrationDB3]
TO  DISK = 'C:\tmp\cx1964ReposDWH\TestIntegrationDB3_20200326.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'TestIntegrationDB3 full Database Backup 20200326',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO


BACKUP DATABASE [TestPresentationDB3]
TO  DISK = 'C:\tmp\cx1964ReposDWH\TestPresentationDB3_20200326.bak'
WITH
  NOFORMAT,
  INIT,
  NAME = 'PresentationDB3 full Database Backup 20200326',
  SKIP,
  NOREWIND,
  NOUNLOAD,
  STATS = 10;
GO

