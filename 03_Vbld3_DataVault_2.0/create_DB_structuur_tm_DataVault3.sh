# file: create_DB_structuur_tm_DataVault.sh
# Functie: creeer structuren (databases, tabellen t/m DataVault 2.0) 
# Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemaakt van een database met een database instance

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0010_create_db_owners3.sql                -o 0010_create_db_owners3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0020_cr_db_TestSource3DB_linux.sql        -o 0020_cr_db_TestSource3DB_linux.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0030_cr_db_TestStaging3DB_linux.sql       -o 0030_cr_db_TestStaging3DB_linux.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0040_cr_db_TestIntegration3DB_linux.sql   -o 0040_cr_db_TestIntegration3DB_linux.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0050_cr_db_TestPresentation3DB_linux.sql  -o 0050_cr_db_TestPresentation3DB_linux.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0060_change_db_owners3.sql                -o 0060_change_db_owners3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0070_create_source_tables3.sql            -o 0070_create_source_tables3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0200_create_staging_tables3.sql           -o 0200_create_staging_tables3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0300_create_hub_tables3.sql               -o 0300_create_hub_tables3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0310_create_sat_tables3.sql               -o 0310_create_sat_tables3.log
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Welkom01 -i 0320_create_link_tables3.sql              -o 0320_create_link_tables3.log
