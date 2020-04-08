# Filenaam: w.py

# dit werkt

# Functie:  werkend python3 script om data via odbc in SQL server database te importeren.
#           Dit voorbeeld laat expliciet zien met numerieke veld op de database omgegaan
#           moet worden in combinatie met NULL values voor verschillende SQL server datatypen
#
#           Dit script verwerkt geen datum velden op de database
#           Dit doet alleen het script insert_data_oas_element_py3.py
#
# Gebruikte python versie: 3.8.2
# Referenties: https://www.got-it.ai/solutions/sqlquerychat/sql-help/data-manipulation/read-and-write-data-to-and-from-sql-server-using-pandas-library-in-python-querychat/
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
#               Draai dit script vanuit Microsoft Visual Code mbv de rechter muis optie "Run Python file in terminal"
#               Zorg dat in Visual code de python interpreter wordt gebruikt uit virtual env env_python3_DWH
#
#  Letop: Dit voorbeeld werkt zowel met de textfiles
#         testtextfile.csv en testtextfile_quoted.csv.
#         In beide gevallen verdwijnen nog de voorloop nullen van het veld id.


import math
import pyodbc
import pandas as pd

# Werkt 
# Voor verwerken van datum velden in CSV
# zie https://kite.com/python/answers/how-to-import-dates-in-a-csv-file-as-datetimes-in-a-pandas-dataframe-in-python

# gebruik van pandas pandas read_csv https://www.marsja.se/pandas-read-csv-tutorial-to-csv/ 



# data = pd.read_csv("C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_himlist_recs_5669.csv"
# Debug:
data = pd.read_csv( "C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_himlist_recs_10.csv"
                    ,skiprows=0
                    ,sep=','
                    ,skip_blank_lines=True
                    ,na_filter= False
                  )

# Debug toon row1. row111 en row132
for index, row in data.iterrows(): 
  print(
#          row,[  1-1], type(row,[1-1])
#         ,row,[111-1], type(row,[1-1])
#         ,row,[132-1], type(row,[1-1])
#         ,row,['punchoutcode'] # alternatief voor row111
   "code: ",row['code']
  ) 


# Debug: Preview the first 10 lines of the loaded data
# Debug: print("Toon Eerste 1None records van de ingelezen set:")  
# Debug: print(data.head(10))
# print(data)
# print (type(data))
# print("Aantal gelezen records: ", data.shape)
print("Aantal gelezen kolommen: ", data.shape[1])
print("Aantal gelezen records : ", data.shape[0])

# Debug Toon DSN info
# dsn_desc = pyodbc.dataSources()
# print (dsn_desc)

# *** Schrijf de Data weg naar een SQL server database obv een odbc dsn ***
# zie ook connect_azuresqldb_vNoneNone5.py
#         pyodbc_voorbeeld_naar_sqlserver_py3.py
sql_conn = pyodbc.connect('DSN=localhost_db_TestSourceDB3;UID=sa;PWD=Welkom01')
cursor = sql_conn.cursor() 

# Maak de tabel leeg, voor het geval al data bevat
cursor.execute("truncate table [codafin12].[oas_himlist]")
print("Table is nu leeg")

# Lees de data uit de textfile in de database
print("Even geduld a.u.b")
print("De data wordt nu naar de database weggeschreven ...")  
for index, row in data.iterrows(): 
  # oas_himlist

  # aanpassing voor smallint dataype
  # omdat python geen NULL kent wordt gebruik gemaakt van None
  l1hdrhide_waarde        = None if row['l1hdrhide']        == 'NULL' else row['l1hdrhide']
  l1ftrhide_waarde        = None if row['l1ftrhide']        == 'NULL' else row['l1ftrhide']
  l1reverse_waarde        = None if row['l1reverse']        == 'NULL' else row['l1reverse']
  l1subtotalsign_waarde   = None if row['l1subtotalsign']   == 'NULL' else row['l1subtotalsign']
  l1order_waarde          = None if row['l1order']          == 'NULL' else row['l1order']
  l2hdrhide_waarde        = None if row['l2hdrhide']        == 'NULL' else row['l2hdrhide']
  l2ftrhide_waarde        = None if row['l2ftrhide']        == 'NULL' else row['l2ftrhide']
  l2reverse_waarde        = None if row['l2reverse']        == 'NULL' else row['l2reverse']
  l2subtotalsign_waarde   = None if row['l2subtotalsign']   == 'NULL' else row['l2subtotalsign']
  l2order_waarde          = None if row['l2order']          == 'NULL' else row['l2order']
  l3hdrhide_waarde        = None if row['l3hdrhide']        == 'NULL' else row['l3hdrhide']
  l3ftrhide_waarde        = None if row['l3ftrhide']        == 'NULL' else row['l3ftrhide']
  l3reverse_waarde        = None if row['l3reverse']        == 'NULL' else row['l3reverse']
  l3subtotalsign_waarde   = None if row['l3subtotalsign']   == 'NULL' else row['l3subtotalsign']
  l3order_waarde          = None if row['l3order']          == 'NULL' else row['l3order']
  l4hdrhide_waarde        = None if row['l4hdrhide']        == 'NULL' else row['l4hdrhide']
  l4ftrhide_waarde        = None if row['l4ftrhide']        == 'NULL' else row['l4ftrhide']
  l4reverse_waarde        = None if row['l4reverse']        == 'NULL' else row['l4reverse']
  l4subtotalsign_waarde   = None if row['l4subtotalsign']   == 'NULL' else row['l4subtotalsign']
  l4order_waarde          = None if row['l4order']          == 'NULL' else row['l4order']
  l5hdrhide_waarde        = None if row['l5hdrhide']        == 'NULL' else row['l5hdrhide']
  l5ftrhide_waarde        = None if row['l5ftrhide']        == 'NULL' else row['l5ftrhide']
  l5reverse_waarde        = None if row['l5reverse']        == 'NULL' else row['l5reverse']
  l5subtotalsign_waarde   = None if row['l5subtotalsign']   == 'NULL' else row['l5subtotalsign']
  l5order_waarde          = None if row['l5order']          == 'NULL' else row['l5order']
  l6hdrhide_waarde        = None if row['l6hdrhide']        == 'NULL' else row['l6hdrhide']
  l6ftrhide_waarde        = None if row['l6ftrhide']        == 'NULL' else row['l6ftrhide']
  l6reverse_waarde        = None if row['l6reverse']        == 'NULL' else row['l6reverse']
  l6subtotalsign_waarde   = None if row['l6subtotalsign']   == 'NULL' else row['l6subtotalsign']
  l6order_waarde          = None if row['l6order']          == 'NULL' else row['l6order']
  l7hdrhide_waarde        = None if row['l7hdrhide']        == 'NULL' else row['l7hdrhide']
  l7ftrhide_waarde        = None if row['l7ftrhide']        == 'NULL' else row['l7ftrhide']
  l7reverse_waarde        = None if row['l7reverse']        == 'NULL' else row['l7reverse']
  l7subtotalsign_waarde   = None if row['l7subtotalsign']   == 'NULL' else row['l7subtotalsign']
  l7order_waarde          = None if row['l7order']          == 'NULL' else row['l7order']
  l8hdrhide_waarde        = None if row['l8hdrhide']        == 'NULL' else row['l8hdrhide']
  l8ftrhide_waarde        = None if row['l8ftrhide']        == 'NULL' else row['l8ftrhide']
  l8reverse_waarde        = None if row['l8reverse']        == 'NULL' else row['l8reverse']
  l8subtotalsign_waarde   = None if row['l8subtotalsign']   == 'NULL' else row['l8subtotalsign']
  l8order_waarde          = None if row['l8order']          == 'NULL' else row['l8order']
  l9hdrhide_waarde        = None if row['l9hdrhide']        == 'NULL' else row['l9hdrhide']
  l9ftrhide_waarde        = None if row['l9ftrhide']        == 'NULL' else row['l9ftrhide']
  l9reverse_waarde        = None if row['l9reverse']        == 'NULL' else row['l9reverse']
  l9subtotalsign_waarde   = None if row['l9subtotalsign']   == 'NULL' else row['l9subtotalsign']
  l9order_waarde          = None if row['l9order']          == 'NULL' else row['l9order']
  l10hdrhide_waarde       = None if row['l10hdrhide']       == 'NULL' else row['l10hdrhide']
  l10ftrhide_waarde       = None if row['l10ftrhide']       == 'NULL' else row['l10ftrhide']
  l10reverse_waarde       = None if row['l10reverse']       == 'NULL' else row['l10reverse']
  l10subtotalsign_waarde  = None if row['l10subtotalsign']  == 'NULL' else row['l10subtotalsign']
  l10order_waarde         = None if row['l10order']         == 'NULL' else row['l10order']
  l11hdrhide_waarde       = None if row['l11hdrhide']       == 'NULL' else row['l11hdrhide']
  l11ftrhide_waarde       = None if row['l11ftrhide']       == 'NULL' else row['l11ftrhide']
  l11reverse_waarde       = None if row['l11reverse']       == 'NULL' else row['l11reverse']
  l11subtotalsign_waarde  = None if row['l11subtotalsign']  == 'NULL' else row['l11subtotalsign']
  l11order_waarde         = None if row['l11order']         == 'NULL' else row['l11order']
  l12hdrhide_waarde       = None if row['l12hdrhide']       == 'NULL' else row['l12hdrhide']
  l12ftrhide_waarde       = None if row['l12ftrhide']       == 'NULL' else row['l12ftrhide']
  l12reverse_waarde       = None if row['l12reverse']       == 'NULL' else row['l12reverse']
  l12subtotalsign_waarde  = None if row['l12subtotalsign']  == 'NULL' else row['l12subtotalsign']
  l12order_waarde         = None if row['l12order']         == 'NULL' else row['l12order']
  leafhdrhide_waarde      = None if row['leafhdrhide']      == 'NULL' else row['leafhdrhide']
  leafftrhide_waarde      = None if row['leafftrhide']      == 'NULL' else row['leafftrhide']
  leafreverse_waarde      = None if row['leafreverse']      == 'NULL' else row['leafreverse']
  leafsubtotalsign_waarde = None if row['leafsubtotalsign'] == 'NULL' else row['leafsubtotalsign']
  leaforder_waarde        = None if row['leaforder']        == 'NULL' else row['leaforder']
  grptype_waarde          = None if row['grptype']          == 'NULL' else row['grptype']
  elmlevel_waarde         = None if row['elmlevel']         == 'NULL' else row['elmlevel']
  useelmname_waarde       = None if row['useelmname']       == 'NULL' else row['useelmname']

  # aanpassing voor int dataype
  # omdat python geen NULL kent wordt gebruik gemaakt van None
  lstseqno_waarde		      = None if row['lstseqno']		      == 'NULL' else row['lstseqno']

  cursor.execute("INSERT INTO [codafin12].[oas_himlist](\
                     [code]\
                    ,[lstseqno]\
                    ,[l1name]\
                    ,[l1hdrtxt]\
                    ,[l1hdrhide]\
                    ,[l1ftrtxt]\
                    ,[l1ftrhide]\
                    ,[l1reverse]\
                    ,[l1subtotalsign]\
                    ,[l1userref1]\
                    ,[l1userref2]\
                    ,[l1userref3]\
                    ,[l1order]\
                    ,[l1manager]\
                    ,[leafmanager]\
                 ) values (\
				           ?,?,?,?,?,?,?,?,?,?,\
                   ?,?,?,?,?\
                 )",
                  row['code']
                 ,lstseqno_waarde

                 ,row['l1name']	       
                 ,row['l1hdrtxt']	   
                 ,l1hdrhide_waarde	   
                 ,row['l1ftrtxt']	   
                 ,l1ftrhide_waarde	   
                 ,l1reverse_waarde   	
                 ,l1subtotalsign_waarde
                 ,row['l1userref1']	   
                 ,row['l1userref2']	   
                 ,row['l1userref3']	   
                 ,l1order_waarde	
                 ,row['l1manager']	   

                 ,row['leafmanager'] # Laatste kolom
                 )

sql_conn.commit() 
cursor.close() 
sql_conn.close() 

print("Einde verwerking")