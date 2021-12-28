# http://www.centinosystems.com/blog/sql/persisting-sql-server-data-in-docker-containers-part-1/

# restart te docker container with SQL databases
export PASSWORD="Welkom01"
# Run Docker conrainer met Docker volume
# /var/opt/mssql
docker run \
       --name 'sql19' \
       -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD='$PASSWORD \
       -p 1433:1433 \
       -v sqldata1:/var/opt/mssql \
       -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

# List the databases in de Docker volume
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Welkom01" -Q 'select name from sys.databases;'