# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# List SQL server databases in Docker container
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -Q "select database_id, name, create_date from sys.databases"

# List used files form databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -Q "select name, physical_name from sys.master_files order by 1"