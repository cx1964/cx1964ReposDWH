rem File: install_python_env.cmd
rem Functie: installatie tbv opzetten van een python3 omgeving
rem opmerking: Uitgangspunt python3 software is al geinstalleerd onder Windows10

rem maak virtuele python environment voor python libraries
python3 -m venv env_python3_DWH

.\env_python3_DWH\Scripts\activate.bat

rem upgrade pip
python -m pip install --upgrade pip

rem install bednodigde python libraries
pip install pyodbc

rem toon geinstalleerde python libraries
pip list