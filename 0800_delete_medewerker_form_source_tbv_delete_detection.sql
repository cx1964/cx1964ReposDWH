/* Filenaam   : 0800_delete_medewerker_form_source_tbv_delete_detection.sql
 * Functie    : delete medewerker nr=000030 tbv delete detection
 *              
 * Opmerkingen: 
 *
 * --------- history ---------------------
 * v.0.0.0   2020-03-03   C.X. la Fontaine
 */

USE TestSourceDB2; 
go

delete from  [TestSourceDB2].[dbo].[Medewerker2]
where nr = '000030';
go
