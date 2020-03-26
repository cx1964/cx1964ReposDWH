# Filenaam: insert_data_py3.py
# Functie:  python3 script om data via odbc in SQL server database te importeren.
# Opmerking: Dit script werkt doordat:
#            - Voor Windows een ODBC definitie is gemaakt
#              [ODBC Driver 17 for SQL Server]
#              Description=Microsoft ODBC Driver 17 for SQL Server
#              Driver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.4.so.1.1
#
#            Zorg dat mbv het script install_python_env.cmd de environmnet is geinstalleerd
#
#            Er is geen odbc.ini file nodig        
#
#            Draai dit script vanuit Microsoft Visual Code mbv de rechter muis optie "Run Selection/Line in Python terminal"
#

import pyodbc


print("Einde verwerking")