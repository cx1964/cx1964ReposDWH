# file: 0910_load_dwh_tm_DataVault3.sh
# Functie: laad hubs, links en sats
# opmerking1: hubs, links en sats kunnen parallel geladen worden, daarom is onderstaande volgorde willekeurig gekozen 
# Opmerking2: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemaakt van een database met een database instance

# Laad DataVault 2.0
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0410_load_LINKS3.sql -o 0410_load_LINKS3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0400_load_HUBs3.sql  -o 0400_load_HUBs3.log
# /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0450_load_SATs3.sql  -o 0450_load_SATs3.log
