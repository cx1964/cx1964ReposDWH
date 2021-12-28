rem file: 0900_load_Staging3.cmd
rem Functie: Laad DWH t/m staging laag
rem Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemkaat van een database met een database instance

rem load staging
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0210_load_staging_tables3.sql -o 0210_load_staging_tables3.log
