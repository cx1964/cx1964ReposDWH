-- File: 8000_TestFact.sql
-- Functie: script tbv testen fact

use [TestPresentationDB2]
go

-- geeft geen records
SELECT   d.code
        ,d.naam 
        ,f.aantal_gepensioneerden 
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
inner join TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
      on (     d.H_Organisatie2HashKey = f.H_Organisatie2HashKey
           and d.meta_load_date = f.meta_load_date
           and d.meta_create_time  = f.meta_create_time
           and d.meta_load_end_date = f.meta_load_end_date 
           and d.meta_create_end_time = f.meta_create_end_time 
         );

-- Analyse 
-- Bekend is dat het huidige vulling van de DBs als volgt is.
-- In de bron is er een mutatie geweest voor medewerker P. Paaltjes (nr='000010')
-- waardoor Er in de SAT nu twee records zijn voor dezwe medewerker.

-- Tbv de FACT is onderstaande brongegevens in de bron tabel Organisatie_Eenheid2
-- en Medewerker2 belangrijk om te weten bij welke Organisatie_Eenheid
-- medewerker Paaltjes werkt.
select  m.nr
       ,m.achternaam
	   ,m.voorletters
	   ,m.aow_datum
	   ,convert(date, getdate()) as datum_van_vandaag
	   ,case when convert(date, getdate()) > m.aow_datum
	         then 'Ja'
		     else 'Nee'
		end as IsMetPensioen
	   ,m.werkt_voor_org_eenheid
	   ,o.code
	   ,o.naam
from [TestSourceDB2].dbo.Medewerker2 m
inner join [TestSourceDB2].dbo.Organisatie_Eenheid2 o
      on o.id = m.werkt_voor_org_eenheid
where 1=1
  and achternaam = 'Paaltjes'

-- Test of FACT TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet
-- alleen voor Paaltjes die met Pensioen is Organisatie_Eenheid 46500 oplevert.

SELECT *
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f;
go

-- Oorzaak verschillen
-- Als men nu scripts 0725 tbv laden facts en script 0715 tbv laden met elkaar vergelijkt
-- valt op dat de load datum+tijd en loadend datum+tijd
-- voor het laden van de fact uit de SAT van medewerker wordt gehaald en voor
-- de DIM uit de SAT van organisatie eenheid. Daarom komen
-- de load datum+tijd en loadend datum+tijd niet overeen.

select d.H_Organisatie2HashKey
      ,d.meta_load_date
	  ,d.meta_create_time
	  ,d.meta_load_end_date
	  ,d.meta_create_end_time
	  ,d.code
FROM TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
where d.code = '46500' 
order by 1,2,3,4,5;
go

select f.H_Organisatie2HashKey
      ,f.meta_load_date
	  ,f.meta_create_time
	  ,f.meta_load_end_date
	  ,f.meta_create_end_time
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
order by 1,2,3,4,5;
go

SELECT   d.code
        ,d.naam 
        ,f.aantal_gepensioneerden
		,'toont nu wel records op join van deel van de kolommen'
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
inner join TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
      on (     d.H_Organisatie2HashKey = f.H_Organisatie2HashKey
	       -- andere twee kolommen van de FK hebben nog niet correcte waarde
	       and d.meta_load_end_date = f.meta_load_end_date 
           and d.meta_create_end_time = f.meta_create_end_time 
         );
go

-- de problem kolommen in PK van DIM en FK van FACT zijn:
           --and d.meta_load_date = f.meta_load_date
           --and d.meta_create_time  = f.meta_create_time
