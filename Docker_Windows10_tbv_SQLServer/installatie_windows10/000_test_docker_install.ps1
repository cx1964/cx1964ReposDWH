# Filenaam:  test_docker_install.ps1
# Functie: Powershell test script om te kijken of Docker installatie goed werkt

# check installed Dokcer version
docker --version

# Check of Docker werkt onder Windows10 (minimaal Pro)
docker run hello-world
