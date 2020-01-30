# DWH ETL voorbeeld tbv DataVault 2.0 en DataMart
Dit voorbeeld gaat uit van een simpel model bestaande uit 2 bron tabellen (Medewerker en Organisatie eenheden).
Voor de eenvoud is de staging laag van het DWH weggelaten.
Voor beide brontabellen is een hub en een sat aangemaakt.
Tgv de foreign key tussen Medewerker en Organisatie, is er ook een link gemaakt.
Het voorbeeld bevat ook een aantal test records.

## Requirements
SQL server database (minimaal SQL2016)

## Beperking mbt de oplossing
Letop in deze oplossing worden de hashkeys die als surrogate keys worden gebruikt in de DataVault
nog gemaakt tijdens het vullen van de HUBs, SATs en LINKs. Echter het maken van de hashkeys dient,
obv de literatuur, al plaats te vinden in de staging laag. Als de hashkeys al gemaakt worden in de staginglaag
is het wel mogelijk om de HUBs, SATs em LINKs parallel te laden. Dit kan dus nu nog niet.

## Business rules
Tbv maximale herbruikbaarheid dienen alle softbusiness rules (zoals berekeningen ed)
gedefineerd te worden in de laag tussen DataVault en DataMart.
Als implentatie suggestie voor het definieren van deze softbusiness rules is het maken van database views
op de Datavault.

In dit voorbeeld is dit nog niet toegepast omdat nog geen relevant voorbeeld is verzonnen.