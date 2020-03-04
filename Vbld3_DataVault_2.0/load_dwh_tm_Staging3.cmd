rem file: full_load_dwh.cmd
rem Functie: full load van alle lagen van het DWH 
rem Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemkaat van een database met een database instance

rem load bron
rem Organisatie eenheden
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0100_insert_source_records_organisatie_eenheid3.sql -o 0100_insert_source_records_organisatie_eenheid3.log
rem Medewerkers
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0120_insert_source_records_medewerker3.sql -o 0120_insert_source_records_medewerker3.log

rem load staging
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0210_load_staging_tables3.sql -o 0210_load_staging_tables3.log
