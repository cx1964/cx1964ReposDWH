# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# create SQL server database owners for DWH databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -i "../../Voorbeeld2_met_Bridge_en_Pit_tables_in_DataVault/0100_insert_source_records_organisatie_eenheid2.sql" -o "./0100_insert_source_records_organisatie_eenheid2.log"
