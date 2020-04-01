# Filenaam: insert_data_oas_element_py3.py
# Functie:  werkend python3 script om data via odbc in SQL server database te importeren.
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
#         Ook worden alle velden als varchar velden ingelezen in de database.
#         Ook de datum velden.

import pyodbc
import pandas as pd

# werkt 
# Voor verwerken van datum velden in CSV
# zie https://kite.com/python/answers/how-to-import-dates-in-a-csv-file-as-datetimes-in-a-pandas-dataframe-in-python

datum_kolommen = ["Geboortedatum"]
data = pd.read_csv("C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_element_recs_10_test.csv"
#data = pd.read_csv("C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_element_recs_262628.csv"
                   ,skiprows=0
                   ,sep=','
                   ,skip_blank_lines=True
                   ,parse_dates=datum_kolommen, dayfirst=True )

# Preview the first 5 lines of the loaded data
print("Toon Eerste 10 records van de ingelezen set:")  
print(data.head(10))
# print(data)
# print (type(data))
# print("Aantal gelezen records: ", data.shape)
print("Aantal gelezen kolommen: ", data.shape[1])
print("Aantal gelezen records : ", data.shape[0])

# Debug Toon DSN info
# dsn_desc = pyodbc.dataSources()
# print (dsn_desc)

# *** Schrijf de Data weg naar een SQL server database obv een odbc dsn ***
# zie ook connect_azuresqldb_v005.py
#         pyodbc_voorbeeld_naar_sqlserver_py3.py
sql_conn = pyodbc.connect('DSN=localhost_db_TestSourceDB3;UID=sa;PWD=Welkom01')
cursor = sql_conn.cursor() 

# Maak de tabel leeg, voor het geval al data bevat
cursor.execute("truncate table [codafin12].[oas_element]")

# Lees de data uit de textfile in de database
print("Even geduld a.u.b")
print("De data wordt nu naar de database weggeschreven ...")  
for index, row in data.iterrows(): 
  #print(row)
  #print alleen de business key
  print(row.)  
  # oas_grplist
  cursor.execute("INSERT INTO [codafin12].[oas_element](\
	               ,[cmpcode]\
	               ,[cmpcode_cs]\
	               ,[code]\
	               ,[code_cs]\
	               ,[elmlevel]\
	               ,[elmlevel_cs]\
	               ,[indirectcode]\
	               ,[tstamp]\
	               ,[name]\
	               ,[sname]\
	               ,[cur]\
	               ,[tax]\
	               ,[accounttype]\
	               ,[statuser]\
	               ,[statpay]\
	               ,[statrec]\
	               ,[descr]\
	               ,[matchable]\
	               ,[statpayint]\
	               ,[summary]\
	               ,[split]\
	               ,[settle]\
	               ,[paper]\
	               ,[elec]\
	               ,[subanal]\
	               ,[taxrepesl]\
	               ,[taxrepintra]\
	               ,[crliminforce]\
	               ,[crlim]\
	               ,[crlim_dp]\
	               ,[taxmethod]\
	               ,[terms]\
	               ,[keepturn]\
	               ,[ten99]\
	               ,[custsuppacc]\
	               ,[discenable]\
	               ,[forcedisperse]\
	               ,[enablepay]\
	               ,[paymode]\
	               ,[priority]\
	               ,[medcode]\
	               ,[tag]\
	               ,[qty1_used]\
	               ,[qty1_title]\
	               ,[qty1_mand]\
	               ,[qty1_balcode]\
	               ,[qty1_dp]\
	               ,[qty2_used]\
	               ,[qty2_title]\
	               ,[qty2_mand]\
	               ,[qty2_balcode]\
	               ,[qty2_dp]\
	               ,[qty3_used]\
	               ,[qty3_title]\
	               ,[qty3_mand]\
	               ,[qty3_balcode]\
	               ,[qty3_dp]\
	               ,[qty4_used]\
	               ,[qty4_title]\
	               ,[qty4_mand]\
	               ,[qty4_balcode]\
	               ,[qty4_dp]\
	               ,[adddate]\
	               ,[moddate]\
	               ,[deldate]\
	               ,[usrname]\
	               ,[accountsummary]\
	               ,[crlimdate]\
	               ,[crlimcurr]\
	               ,[elmstat]\
	               ,[sic]\
	               ,[crmanager]\
	               ,[crrating]\
	               ,[crratingdate]\
	               ,[crref]\
	               ,[cragency]\
	               ,[dateaccopened]\
	               ,[paymentindex]\
	               ,[taxadjustment]\
	               ,[matchtopo]\
	               ,[extval]\
	               ,[arcpaid]\
	               ,[arcrecon]\
	               ,[ten99code]\
	               ,[subslevel]\
	               ,[subselm]\
	               ,[temporaryelm]\
	               ,[maxtemporaryid]\
	               ,[allowtaxnum]\
	               ,[allowlangcode]\
	               ,[allowctycode]\
	               ,[forceterms]\
	               ,[forcetaxnum]\
	               ,[forceaddress]\
	               ,[force1099]\
	               ,[startyear]\
	               ,[startperiod]\
	               ,[endyear]\
	               ,[endperiod]\
	               ,[statmemo]\
	               ,[balancingacc]\
	               ,[catcode]\
	               ,[assetelement]\
	               ,[extcode]\
	               ,[extconfig]\
	               ,[procorders]\
	               ,[procreq]\
	               ,[repcode1]\
	               ,[repcode2]\
	               ,[repcode3]\
	               ,[punchoutcode]\
	               ,[punchouturl]\
	               ,[punchoutdomain]\
	               ,[punchoutuser]\
	               ,[punchoutpasswd]\
	               ,[punchoutidcode]\
	               ,[punchoutenc]\
	               ,[punchoutmktplace]\
	               ,[custsuppaccext]\
	               ,[autoreceipt]\
	               ,[procstatus]\
	               ,[tolerancecode]\
	               ,[matchingoffset]\
	               ,[proctranslimit]\
	               ,[proctranslimit_dp]\
	               ,[proccalloffs]\
	               ,[procgrns]\
	               ,[procreturns]\
	               ,[procemailsal]\
	               ,[procemailsub]\
	               ,[euvatcode]\
               	,[longname]\
                 ) values (\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?,?,?,?,?,?,?,?,?\
                    ?,?\
                 )",
	 row['cmpcode']
	,row['cmpcode_cs']
	,row['code']
	,row['code_cs']
	,row['elmlevel']
	,row['elmlevel_cs']
	,row['indirectcode']
	,row['tstamp']
	,row['name']
	,row['sname']
	,row['cur']
	,row['tax']
	,row['accounttype']
	,row['statuser']
	,row['statpay']
	,row['statrec']
	,row['descr']
	,row['matchable']
	,row['statpayint']
	,row['summary']
	,row['split']
	,row['settle']
	,row['paper']
	,row['elec']
	,row['subanal']
	,row['taxrepesl']
	,row['taxrepintra']
	,row['crliminforce']
	,row['crlim']
	,row['crlim_dp']
	,row['taxmethod']
	,row['terms']
	,row['keepturn']
	,row['ten99']
	,row['custsuppacc']
	,row['discenable']
	,row['forcedisperse']
	,row['enablepay']
	,row['paymode']
	,row['priority']
	,row['medcode']
	,row['tag']
	,row['qty1_used']
	,row['qty1_title']
	,row['qty1_mand']
	,row['qty1_balcode']
	,row['qty1_dp']
	,row['qty2_used']
	,row['qty2_title']
	,row['qty2_mand']
	,row['qty2_balcode']
	,row['qty2_dp']
	,row['qty3_used']
	,row['qty3_title']
	,row['qty3_mand']
	,row['qty3_balcode']
	,row['qty3_dp']
	,row['qty4_used']
	,row['qty4_title']
	,row['qty4_mand']
	,row['qty4_balcode']
	,row['qty4_dp']
	,row['adddate']
	,row['moddate']
	,row['deldate']
	,row['usrname']
	,row['accountsummary']
	,row['crlimdate']
	,row['crlimcurr']
	,row['elmstat']
	,row['sic']
	,row['crmanager']
	,row['crrating']
	,row['crratingdate']
	,row['crref']
	,row['cragency']
	,row['dateaccopened']
	,row['paymentindex']
	,row['taxadjustment']
	,row['matchtopo']
	,row['extval']
	,row['arcpaid']
	,row['arcrecon']
	,row['ten99code']
	,row['subslevel']
	,row['subselm']
	,row['temporaryelm']
	,row['maxtemporaryid']
	,row['allowtaxnum']
	,row['allowlangcode']
	,row['allowctycode']
	,row['forceterms']
	,row['forcetaxnum']
	,row['forceaddress']
	,row['force1099']
	,row['startyear']
	,row['startperiod']
	,row['endyear']
	,row['endperiod']
	,row['statmemo']
	,row['balancingacc']
	,row['catcode']
	,row['assetelement']
	,row['extcode']
	,row['extconfig']
	,row['procorders']
	,row['procreq']
	,row['repcode1']
	,row['repcode2']
	,row['repcode3']
	,row['punchoutcode']
	,row['punchouturl']
	,row['punchoutdomain']
	,row['punchoutuser']
	,row['punchoutpasswd']
	,row['punchoutidcode']
	,row['punchoutenc']
	,row['punchoutmktplace']
	,row['custsuppaccext']
	,row['autoreceipt']
	,row['procstatus']
	,row['tolerancecode']
	,row['matchingoffset']
	,row['proctranslimit']
	,row['proctranslimit_dp']
	,row['proccalloffs']
	,row['procgrns']
	,row['procreturns']
	,row['procemailsal']
	,row['procemailsub']
	,row['euvatcode']
	,row['longname'])
sql_conn.commit() 
cursor.close() 
sql_conn.close() 


print("Einde verwerking")