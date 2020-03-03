rem file: full_load_dwh.cmd
rem Functie: full load van alle lagen van het DWH 
rem Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemkaat van een database met een database instance

rem load bron
rem Organisatie eenheden
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0100_insert_source_records_organisatie_eenheid.sql -o 0100_insert_source_records_organisatie_eenheid.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0110_update_source_records_organisatie_eenheid.sql -o 0110_update_source_records_organisatie_eenheid.log
rem Medewerkers
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0120_insert_source_records_medewerker.sql -o 0120_insert_source_records_medewerker.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0130_update_source_records_medewerker.sql -o 0110_0130_update_source_records_medewerker.log


rem load staging
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0210_load_staging_tables.sql -o 0210_load_staging_tables.log



rem load DataVault
rem volgorde is willekeurig kan parallel geladen worden
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0400_load_HUBs.sql -o 0400_load_HUBs.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0410_load_LINKS.sql -o 0410_load_LINKS.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0440_load_SATs.sql -o 0440_load_SATs.log


rem load DataMart
rem volgorde is willekeurig kan parallel geladen worden
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0700_load_dims_speciale_records.sql -o 0700_load_dims_speciale_records.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0710_load_dims_obv_DataVault.sql -o 0710_load_dims_obv_DataVault.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0720_load_facts_obv_DataVault.sql -o 0720_load_facts_obv_DataVault.log
