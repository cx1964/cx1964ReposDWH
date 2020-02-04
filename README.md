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

### Letop
Het gebruik van hashkeys tbv surrogate keys gaat er vanuit dat er geen lookup in de HUB tabel nodig is
om de waarde van hashkey uit de HUB tabel (= H_<HUBnaaam>) te bepalen voor het toevoegen van een nieuwe SAT of LINK,
waardoor HUBs, SATs en LINKs parallel toegevoegd kunnen worden. Dit komt doordat de hashkey van de HUB altijd bepaald
kan worden la smen de waarde heeft van de business key die hoort bij betreffende HUB. De hashkey van de HUB
kan men namelijk berekenen mbv een functie obv de business key van de HUB. Deze informatie is beschikbaar in de
staging laag van het DWH, tijdens het toevoegen van de HUB, SAT en LINK. 


## Business rules
Tbv maximale herbruikbaarheid dienen alle softbusiness rules (zoals berekeningen ed)
gedefineerd te worden in de laag tussen DataVault en DataMart.
Als implementatiesuggestie voor het definieren van deze softbusiness rules is het maken van database views
op de Datavault.

In dit voorbeeld is dit nog niet toegepast omdat nog geen relevant voorbeeld is verzonnen.