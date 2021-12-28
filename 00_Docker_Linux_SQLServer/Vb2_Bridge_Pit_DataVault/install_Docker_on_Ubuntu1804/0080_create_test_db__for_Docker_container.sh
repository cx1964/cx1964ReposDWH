# https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

# create SQL server database in container named myTestDatabase
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -Q 'CREATE DATABASE myTestDB1' 

# Check database is created
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -Q 'select name from sys.databases;'                             