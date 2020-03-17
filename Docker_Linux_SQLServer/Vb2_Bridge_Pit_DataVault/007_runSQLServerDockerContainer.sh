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
       -v mssqlserverdata1:/var/opt/mssql \
       -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

# Letop tgv -v mssqlserverdata1:/var/opt/mssql
# Wordt er een docker volume aangemaakt.
# De docker volume voor de container heet mssqlserverdata1
# De docker volume mssqlserverdata1 wordt standaard fysiek op de linux host aangemaakt
# in de directory /var/lib/docker/volumes/mssqlserverdata1
# Als men database aanmaakt hoeft men geen database filenamen op te geven in het create database command.
# De database files komen op de linux host in de directory /var/lib/docker/volumes/mssqlserverdata1/_data/data.
# De filenamen van de database files komen in de container in de directory var/opt/mssql

# check container
docker ps -a

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