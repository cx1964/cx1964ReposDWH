# Filenaam: insert_data_py3.py
# Functie:  python3 script om data via odbc in SQL server database te importeren.
# Gebruikte python versie: 3.8.2
# Opmerking:
#             Requirements Windows:
#             - Zorg dat mbv het script install_python_env.cmd de environment is geinstalleerd
#             - Install odbc driver voor sql server (driver 17) 64-bits versie
#             - Zorg dat met odbc-gegevensbronbeheer 64-bits de volgende Gebruikers-DSNs zijn aangemaakt
#               met connectie gegevens naar de SQL Server databases:
#               - localhost_db_TestSourceDB3
#               - localhost_db_TestStagingDB3
#               - localhost_db_TestIntegrationDB3
#               - localhost_db_TestPresentationDB3
#               Draai dit script vanuit Microsoft Visual Code mbv de rechter muis optie "Run Selection/Line in Python terminal"
# Referenties: https://www.got-it.ai/solutions/sqlquerychat/sql-help/data-manipulation/read-and-write-data-to-and-from-sql-server-using-pandas-library-in-python-querychat/

import pyodbc
import pandas as pd

df = pd.read_csv("testtextfile.csv", delimiter = ' ')
print(df.head(7))
print("Einde verwerking")