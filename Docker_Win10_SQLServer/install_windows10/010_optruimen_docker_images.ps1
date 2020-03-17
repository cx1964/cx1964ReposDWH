# File: 010_optruimen_docker_images.ps1
# Functie: powershell script tbv opruimen van Docker images

# opvragen beschikbare Docker images
docker image ls

# verwijderen image
# gebruikte formaat <respository>:<tag>
docker rmi mcr.microsoft.com/mssql/server:latest
