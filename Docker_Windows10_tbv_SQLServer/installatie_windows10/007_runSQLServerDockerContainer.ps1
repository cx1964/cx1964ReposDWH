# File: 007_runSQLServerDockerContainer.ps1
# Functie: powershell voorbeeld run SQL database onder Docker Windows
#          Om mbv SQL Server management studio te connecten
#          gebruik connectie gegevens:
#          -- connect obv SQL Server Authentication
#          -- server name: gebruik de waarde van de hostname van de machine waarop de conrainer draait (in cmd shell geef commando hostname)
#          -- login: sa
#          -- Password: Welkom01 (= password opgegeven in het docker run command)      

# --- ToDo 
#          Nog oplossen !!!!
# --- letop in dit script werkt het gebruik van docker volumes nog niet goed
#     Dit getekent, dat an het stoppen van de Docker image, de data wweg is  



# for avaiable SQL Server Docker containers see
# https://hub.docker.com/_/microsoft-mssql-server

# docker pull mcr.microsoft.com/mssql/server
# Run Docker conrainer met Docker volume
# c:\SQLDatabase
docker run -d --name 'sql2019' -e ACCEPT_EULA=Y -e MSSQL_SA_PASSWORD=Welkom01 -p 1433:1433 -v c:\SQLDatabase:/sql mcr.microsoft.com/mssql/server:2019-latest

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