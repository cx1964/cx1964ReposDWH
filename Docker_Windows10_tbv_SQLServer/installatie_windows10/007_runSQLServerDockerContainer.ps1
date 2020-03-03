# File: 007_runSQLServerDockerContainer.ps1
# Functie: powershell voorbeeld run SQL database onder Docker Windows
#          Om mbv SQL Server management studio te connecten
#          gebruik connectie gegevens:
#          -- connect obv SQL Server Authentication
#          -- server name: gebruik de waarde van de hostname van de machine waarop de conrainer draait (in cmd shell geef commando hostname)
#          -- login: sa
#          -- Password: Welkom01 (= password opgegeven in het docker run command)      
#         
# for avaiable SQL Server Docker containers see
# https://hub.docker.com/_/microsoft-mssql-server

# docker pull mcr.microsoft.com/mssql/server

# Onderstaande werkt
# Run Docker conrainer met Docker volume
# zie https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker?view=sql-server-ver15
# Hierin is C:\SQLDatabase een local directory op host waarop Docker draait.
# C:\SQLDatabase  wordt in onderstaand command gebruikt als Dockervolume, zodat de data persistent is, na het stoppen van de container.
# Deze directory voor de docker volume wordt automatisch aangemaakt als deze nog niet bestaat.
# Docker gebruikt / in directorynamen van local directories
# Connect met deze database obv sa database user en opgegeven password en servername = hostname van de host waarop Dokcer draait .
# Deze werkt:
# docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Welkom01" -p 1433:1433 -v C:/SQLDatabase/data:/var/opt/mssql/data -v C:/SQLDatabase/log:/var/opt/mssql/log -v C:/SQLDatabase/secrets:/var/opt/mssql/secrets -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04
# Deze werkt:
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Welkom01" -p 1433:1433 -v C:/SQLDatabase/data:/var/opt/mssql/data -v C:/SQLDatabase/log:/var/opt/mssql/log -v C:/SQLDatabase/secrets:/var/opt/mssql/secrets -d mcr.microsoft.com/mssql/server:2019-latest

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
#   Driver name: MS SQL Server/SQL Server
#   Settings
#           Thrust Server Certificate ON
#
# Use <test connection> button