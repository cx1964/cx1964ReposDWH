/* Filenaam   : 0060_change_db_owners3.sql
 * Functie    : SQL-T SQL2016
 *              script tbv toewijzen van de applicatie database user
 *              als owner van de database tbv voorbeeld3
 * Opmerkingen: Dit script moet gedraaid worden nadat de lege database is gemaakt
 *
 * --------- history ---------------------
 * v.0.0.0   2020-03-04   C.X. la Fontaine
 */


-- *** Begin Change owner TestSourceDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestSourceDB3
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerSource3'
go
-- *** Einde Change owner TestSourceDB DB ***


-- *** Begin Change owner TestStagingDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestStagingDB3
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerStaging3'
go
-- *** Einde Change owner TestIntegrationDB DB ***


-- *** Begin Change owner TestIntegrationDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestIntegrationDB3
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerIntegration3'
go
-- *** Einde Change owner TestIntegrationDB DB ***

-- *** Begin Change owner TestPresentationDB DB ***
/* Selecteer de nieuwe lege applicatie database */ 
use TestPresentationDB3
go

/* Maak de Applicatie database user eigenaar van de database */
exec dbo.sp_changedbowner @loginame =  'myTestDBOwnerPresentation3'
go
-- *** Einde Change owner TestIntegrationDB DB ***