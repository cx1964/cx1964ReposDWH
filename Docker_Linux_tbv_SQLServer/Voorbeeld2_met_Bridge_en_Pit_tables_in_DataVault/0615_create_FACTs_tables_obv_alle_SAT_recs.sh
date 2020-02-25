# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# create SQL server database owners for DWH databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -i "../../Vbld2_Bridge_en_Pit_tables_DV/0615_create_FACTs_tables_obv_alle_SAT_recs.sql" -o "./0615_create_FACTs_tables_obv_alle_SAT_recs.log"
