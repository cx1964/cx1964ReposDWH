rem file: create_DB_structuur_tm_DataVault.cmd
rem Functie: creeer structuren (databases, tabellen t/m DataVault 2.0) 
rem Opmerking: Als dit script tegen de native SQL server (zonder docker draait) wordt gebruik gemkaat van een database met een database instance

sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0010_create_db_owners3.sql          -o 0010_create_db_owners3.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0020_cr_db_TestSource3DB.sql        -o 0020_cr_db_TestSource3DB.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0030_cr_db_TestStaging3DB.sql       -o 0030_cr_db_TestStaging3DB.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0040_cr_db_TestIntegration3DB.sql   -o 0040_cr_db_TestIntegration3DB.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0050_cr_db_TestPresentation3DB.sql  -o 0050_cr_db_TestPresentation3DB.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0060_change_db_owners3.sql          -o 0060_change_db_owners3.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0070_create_source_tables3.sql      -o 0070_create_source_tables3.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0200_create_staging_tables.sql      -o 0200_create_staging_tables.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0300_create_hub_tables.sql          -o 0300_create_hub_tables.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0310_create_sat_tables.sql          -o 0310_create_sat_tables.log
sqlcmd -S C1Z68Y2\TEST_C1Z68Y2 -U sa -P Welkom01 -i 0320_create_link_tables.sql         -o 0320_create_link_tables.log