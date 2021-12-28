rem file: 0910_load_dwh_tm_DataVault3.cmd
rem Functie: laad hubs, links en sats
rem opmerking1: hubs, links en sats kunnen parallel geladen worden, daarom is onderstaande volgorde willekeurig gekozen 
rem Opmerking2: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemkaat van een database met een database instance

rem Laad DataVault 2.0
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0410_load_LINKS3.sql -o 0410_load_LINKS3.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0400_load_HUBs3.sql  -o 0400_load_HUBs3.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0450_load_SATs3.sql  -o 0450_load_SATs3.log
