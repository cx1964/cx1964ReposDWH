-- Filenaam: script_checkwaardes_zoekt_waarde_in_alle_tabellen_sql2012_LETOP_aanpassing_v_Primavera_obv_views.sql

use [Pmdb] -- Aanpassen

-- Filenaam : script_checkwaardes_zoekt_waarde_in_alle_tabellen_sql2012.sql
-- Functie  : Zoekt naar kolommen in een SQl Server database op basis van kolom waarden
-- Opmerking: Script maakt gebruik van temp tabellen.
--            Script is ook geschikt voor SQL2012

/*deze code kan in alle tekst-achtige kolommen in de database naar een waarde zoeken.

de resulten van de zoektocht komen in de tijdelije tabel #resultaten
(tabelnaam, kolomnaam)
de code maakt hier een select op en gooit vervolgens de tabel weer weg

 er zit ook een hulptabel ##voortgang bij, als de procedure lang duurt
 kan je tussentijds met zelf een select * op deze tabel de voortgang zien.
(in een ander tabbladje van management studio)
*/


CREATE TABLE #resultaat (tabelkolom varchar(max))
/*tijdelijke tabel met de zoekresultaten */

CREATE TABLE ##voortgang (tabel varchar(max))
/*tijdelijke tabel met de tabelnaam waar de code op dat moment mee bezig is.
even op querien als het heel lang duurt */


BEGIN

	DECLARE @ZoekWaarde varchar(200)
	set @Zoekwaarde = 'xdwh PO&U prognoses voorbeeldproject'
	/* dit is de waarde waarnaar gezocht gaat worden in alle tabellen en views */
	
	
	DECLARE @schema AS nvarchar(100)
	set @schema = 'pxrptuser' --schema waarin de te doorzoeken tabellen staan
			
	DECLARE @tabel AS nvarchar(255) --variabele om alle tabellen te doorlopen
	DECLARE @kolom AS nvarchar(255) --variabele om alle kolommen te doorlopen
	
	DECLARE @sql  AS nvarchar(4000) --hierin komt steeds de sql-statement die zoekt naar de waarde
	DECLARE @sql2 AS nvarchar(4000) 

	DECLARE curSysteemTabellen CURSOR --doorloopt alle tabellen
	FOR 
		select distinct
			TABLE_NAME
		from 
			INFORMATION_SCHEMA.VIEWS -- Letop voor Primavera Extentned Tables kijk in views ipv tables
		where
			-- not(TABLE_NAME like 'mi_%') --specifiek criterium voor BPMone
			-- and
			TABLE_SCHEMA = @schema
		
	OPEN curSysteemTabellen
	
	FETCH NEXT FROM curSysteemTabellen INTO @tabel

	WHILE @@FETCH_STATUS = 0
	BEGIN

	raiserror(@tabel, 10,1) with nowait
	/* in het Messages tabblad kun je de voortgang zien */
	insert into ##voortgang values (@tabel)
	/* of met een select * op ##voortgang, 
	werkt alleen tijdens het uitvoeren van de code */
	
		DECLARE curSysteemTabellenKolommen CURSOR 
		/* geneste subcursor die alle bij @tabel horende kolommen doorloopt */
		FOR 
			select
				COLUMN_NAME
			from 
				INFORMATION_SCHEMA.COLUMNS
			where
				TABLE_NAME = @tabel
				and TABLE_SCHEMA = @schema
				and data_type in ('char','nvarchar', 'varchar' )  --hier alleen text-achtige datatypes
					--zouden ook b.v. numerieke types kunnen zijn, maar dan moet er een convert
					--naar varchar in de @sql verderop.
		

		OPEN curSysteemTabellenKolommen
	
		FETCH NEXT FROM curSysteemTabellenKolommen INTO @kolom

		WHILE @@FETCH_STATUS = 0
		BEGIN

			SET @sql = 'insert into #resultaat SELECT ''' + @tabel + ',' + @kolom +  
		   ''' FROM [' + @schema + '].[' 
			+ @tabel + '] WHERE [' + @kolom + '] like ' + '''%' + @ZoekWaarde + '%'''
			execute(@sql) 
				/* dit is het sql-statement dat de betreffende kolom doorzoekt
				je zou 'like' weg kunnen laten, of hier een convert doen
				als je ook andere datatypes (date, int etc) wil doorzoeken */

			--SET @sql2 = 'SELECT distinct  ''' + @tabel + ',' + @kolom +  
		 --  ''' FROM [' + @schema + '].[' 
			--+ @tabel + '] WHERE [' + @kolom + '] like ' + '''%' + @ZoekWaarde + '%'''
			--execute(@sql2)
				
			FETCH NEXT FROM curSysteemTabellenKolommen INTO @kolom
		END --fetch curSysteemTabellenKolommen loop
		CLOSE curSysteemTabellenKolommen
		DEALLOCATE curSysteemTabellenKolommen
		
	FETCH NEXT FROM curSysteemTabellen INTO @tabel
	
END --fetch curSysteemTabellen loop
CLOSE curSysteemTabellen

DEALLOCATE curSysteemTabellen


select distinct tabelkolom from #resultaat --presenteer de resultaten


drop TABLE #resultaat
drop TABLE ##voortgang
/*tijdelijke tabellen opruimen */


END  --stored procedure
