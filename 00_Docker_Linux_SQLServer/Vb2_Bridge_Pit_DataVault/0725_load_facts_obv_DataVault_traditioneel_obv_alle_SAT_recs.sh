# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# create SQL server database owners for DWH databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -i "../../Vbld2_Bridge_en_Pit_tables_DV/0725_load_facts_obv_DataVault_traditioneel_obv_alle_SAT_recs.sql" -o "./0725_load_facts_obv_DataVault_traditioneel_obv_alle_SAT_recs.log"
