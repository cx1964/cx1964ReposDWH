rem file: 0900_load_dwh_tm_Staging3.cmd
rem functie: Laad brondata
rem Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemaakt van een database met een database instance

rem load bron
rem Organisatie eenheden
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0100_insert_source_records_organisatie_eenheid3.sql -o 0100_insert_source_records_organisatie_eenheid3.log
rem Medewerkers
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0120_insert_source_records_medewerker3.sql -o 0120_insert_source_records_medewerker3.log

