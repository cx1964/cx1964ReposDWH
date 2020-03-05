# file: 0900_load_bron3.sh
# functie: Laad brondata
# Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemaakt van een database met een database instance

# load bron
# Organisatie eenheden
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0100_insert_source_records_organisatie_eenheid3.sql -o 0100_insert_source_records_organisatie_eenheid3.log
# Medewerkers
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0120_insert_source_records_medewerker3.sql -o 0120_insert_source_records_medewerker3.log
