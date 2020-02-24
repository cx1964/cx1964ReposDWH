# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# create SQL server database owners for DWH databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -i "../../Vbld2_Bridge_en_Pit_tables_DV/0440_cr_load_procedure_SAT_Organisatie_Eenheid.sql" -o "./0440_cr_load_procedure_SAT_Organisatie_Eenheid.log"
