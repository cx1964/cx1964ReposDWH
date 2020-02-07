# http://www.centinosystems.com/blog/sql/persisting-sql-server-data-in-docker-containers-part-1/
# remark: 

# for avaiable SQL Server Docker containers see
# https://hub.docker.com/_/microsoft-mssql-server


export PASSWORD="Welkom01"
# Run Docker conrainer met Docker volume
# /var/opt/mssql
docker run \
       --name 'sql19' \
       -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD='$PASSWORD \
       -p 1433:1433 \
       -v sqldata1:/var/opt/mssql \
       -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04


# use DBeaver to test connection
# https://dbeaver.io/    
# use conection info:
# SQL server
#   host: localhost
#   port: 1433
#   Database/Schema: master   
#   Autehnitaction: SQL Server Authentication
#   username: sa
#   pwassword: Welkom01
#   Diver name: MS SQL Server/SQL Server
#   Settings
#           Thrust Server Certificate ON
#
# Use <test connection> button