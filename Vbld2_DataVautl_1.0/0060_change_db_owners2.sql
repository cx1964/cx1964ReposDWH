/* Filenaam   : 0060_change_db_owners2.sql
 * Functie    : SQL-T SQL2016
 *              script tbv toewijzen van de applicatie database user
 *              als owner van de database tbv voorbeeld2
 * Opmerkingen: Dit script moet gedraaid worden nadat de lege database is gemaakt
 *
 * --------- history ---------------------
 * v.0.0.0   2020-01-21   C.X. la Fontaine
 */


-- *** Begin Change owner TestSourceDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestSourceDB2
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerSource2'
go
-- *** Einde Change owner TestSourceDB DB ***


-- *** Begin Change owner TestStagingDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestStagingDB2
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerStaging2'
go
-- *** Einde Change owner TestIntegrationDB DB ***


-- *** Begin Change owner TestIntegrationDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestIntegrationDB2
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerIntegration2'
go
-- *** Einde Change owner TestIntegrationDB DB ***

-- *** Begin Change owner TestPresentationDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestPresentationDB2
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerPresentation2'
go
-- *** Einde Change owner TestIntegrationDB DB ***