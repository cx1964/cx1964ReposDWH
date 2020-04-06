# Filenaam: voorbeeld_pandas_pyodbc_null_values.py
# Functie:  werkend python3 script om data via odbc in SQL server database te importeren.
#           Dit voorbeeld laat expliciet zien met numerieke veld op de database omgeggaan moet worden incombinatie met NULL values
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

import math
import pyodbc
import pandas as pd


# werkt 
# Voor verwerken van datum velden in CSV
# zie https://kite.com/python/answers/how-to-import-dates-in-a-csv-file-as-datetimes-in-a-pandas-dataframe-in-python

# gebruik van pandas pandas read_csv https://www.marsja.se/pandas-read-csv-tutorial-to-csv/ 

# datum_kolommen bevat alle kolomnamen van alle kolommen van het dataype date op de database
datum_kolommen = [ 
                   "adddate"
                  ,"moddate"
                  ,"deldate"
                  ,"crlimdate"
                  ,"crratingdate"
                  ,"dateaccopened"
                 ]

#data = pd.read_csv("C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_element_recs_262628.csv"
data = pd.read_csv( "C:\\tmp\\weg\Data\\20200330data_dwh_stg_oas_element_recs_10_test.csv"
                   ,skiprows=0
                   ,sep=','
                   ,skip_blank_lines=True
                   ,na_filter= False
                   ,parse_dates=datum_kolommen, dayfirst=True )

# Debug toon row1. row111 en row132
# for index, row in data.iterrows(): 
#   print( row[  1-1], type(row[1-1])
#         ,row[111-1], type(row[1-1])
#         ,row[132-1], type(row[1-1])
#         ,row['punchoutcode'] # alternatief voor row111
#   ) 



# Preview the first 10 lines of the loaded data
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
print("Table is nu leeg")

# Lees de data uit de textfile in de database
print("Even geduld a.u.b")
print("De data wordt nu naar de database weggeschreven ...")  
for index, row in data.iterrows(): 
  # oas_element

  # aanpassing voor smallint dataype
  # omdat python geen NULL kent wordt gebruik gemaakt van None
  elmlevel_waarde			= 0 if row['elmlevel']			== 'NULL' else None
  tstamp_waarde				= 0 if row['tstamp']			== 'NULL' else None
  accounttype_waarde		= 0 if row['accounttype']		== 'NULL' else None
  statpay_waarde			= 0 if row['statpay']			== 'NULL' else None
  statrec_waarde			= 0 if row['statrec']			== 'NULL' else None
  descr_waarde				= 0 if row['descr']				== 'NULL' else None
  matchable_waarde			= 0 if row['matchable']			== 'NULL' else None
  summary_waarde			= 0 if row['summary']			== 'NULL' else None
  split_waarde				= 0 if row['split']				== 'NULL' else None
  paper_waarde				= 0 if row['paper']				== 'NULL' else None
  elec_waarde				= 0 if row['elec']				== 'NULL' else None
  subanal_waarde			= 0 if row['subanal']			== 'NULL' else None
  taxrepesl_waarde			= 0 if row['taxrepesl']			== 'NULL' else None
  taxrepintra_waarde		= 0 if row['taxrepintra']		== 'NULL' else None
  crliminforce_waarde		= 0 if row['crliminforce']		== 'NULL' else None
  crlim_dp_waarde			= 0 if row['crlim_dp']			== 'NULL' else None
  taxmethod_waarde			= 0 if row['taxmethod']			== 'NULL' else None
  keepturn_waarde			= 0 if row['keepturn']			== 'NULL' else None
  ten99_waarde				= 0 if row['ten99']				== 'NULL' else None
  custsuppacc_waarde		= 0 if row['custsuppacc']		== 'NULL' else None
  discenable_waarde			= 0 if row['discenable']		== 'NULL' else None
  forcedisperse_waarde		= 0 if row['forcedisperse']		== 'NULL' else None
  enablepay_waarde			= 0 if row['enablepay']			== 'NULL' else None
  priority_waarde			= 0 if row['priority']			== 'NULL' else None
  tag_waarde				= 0 if row['tag']				== 'NULL' else None
  qty1_used_waarde			= 0 if row['qty1_used']			== 'NULL' else None
  qty1_mand_waarde			= 0 if row['qty1_mand']			== 'NULL' else None
  qty1_dp_waarde			= 0 if row['qty1_dp']			== 'NULL' else None
  qty2_used_waarde			= 0 if row['qty2_used']			== 'NULL' else None
  qty2_mand_waarde			= 0 if row['qty2_mand']			== 'NULL' else None
  qty2_dp_waarde			= 0 if row['qty2_dp']			== 'NULL' else None
  qty3_used_waarde			= 0 if row['qty3_used']			== 'NULL' else None
  qty3_mand_waarde			= 0 if row['qty3_mand']			== 'NULL' else None
  qty3_dp_waarde			= 0 if row['qty3_dp']			== 'NULL' else None
  qty4_used_waarde			= 0 if row['qty4_used']			== 'NULL' else None
  qty4_mand_waarde			= 0 if row['qty4_mand']			== 'NULL' else None
  qty4_dp_waarde			= 0 if row['qty4_dp']			== 'NULL' else None
  crlimcurr_waarde			= 0 if row['crlimcurr']			== 'NULL' else None
  taxadjustment_waarde		= 0 if row['taxadjustment']		== 'NULL' else None
  matchtopo_waarde			= 0 if row['matchtopo']			== 'NULL' else None
  arcpaid_waarde			= 0 if row['arcpaid']			== 'NULL' else None
  arcrecon_waarde			= 0 if row['arcrecon']			== 'NULL' else None
  subslevel_waarde			= 0 if row['subslevel']			== 'NULL' else None
  temporaryelm_waarde		= 0 if row['temporaryelm']		== 'NULL' else None
  allowtaxnum_waarde		= 0 if row['allowtaxnum']		== 'NULL' else None
  allowlangcode_waarde		= 0 if row['allowlangcode']		== 'NULL' else None
  allowctycode_waarde		= 0 if row['allowctycode']		== 'NULL' else None
  forceterms_waarde			= 0 if row['forceterms']		== 'NULL' else None
  forcetaxnum_waarde		= 0 if row['forcetaxnum']		== 'NULL' else None
  forceaddress_waarde		= 0 if row['forceaddress']		== 'NULL' else None
  force1099_waarde			= 0 if row['force1099']			== 'NULL' else None
  startyear_waarde			= 0 if row['startyear']			== 'NULL' else None
  startperiod_waarde		= 0 if row['startperiod']		== 'NULL' else None
  endyear_waarde			= 0 if row['endyear']			== 'NULL' else None
  endperiod_waarde			= 0 if row['endperiod']			== 'NULL' else None
  assetelement_waarde		= 0 if row['assetelement']		== 'NULL' else None
  extconfig_waarde			= 0 if row['extconfig']			== 'NULL' else None

  punchoutenc_waarde		= 0 if row['punchoutenc']		== 'NULL' else None
  punchoutmktplace_waarde	= 0 if row['punchoutmktplace']	== 'NULL' else None
  custsuppaccext_waarde		= 0 if row['custsuppaccext']	== 'NULL' else None
  autoreceipt_waarde		= 0 if row['autoreceipt']		== 'NULL' else None
  procstatus_waarde			= 0 if row['procstatus']		== 'NULL' else None
  tolerancecode_waarde		= 0 if row['tolerancecode']		== 'NULL' else None
  matchingoffset_waarde		= 0 if row['matchingoffset']	== 'NULL' else None

  proctranslimit_dp_waarde	= 0 if row['proctranslimit_dp']	== 'NULL' else None

  # aanpassing voor int dataype
  # omdat python geen NULL kent wordt gebruik gemaakt van None
  cmpcode_cs_waarde			= 0 if row['cmpcode_cs']		== 'NULL' else None
  code_cs_waarde			= 0 if row['code_cs']			== 'NULL' else None
  elmlevel_cs_waarde		= 0 if row['elmlevel_cs']		== 'NULL' else None
  statpayint_waarde			= 0 if row['statpayint']		== 'NULL' else None
  maxtemporaryid_waarde		= 0 if row['maxtemporaryid']	== 'NULL' else None

  # aanpassing voor money dataype
  # omdat python geen NULL kent wordt gebruik gemaakt van None
  crlim_waarde			= 0 if row['crlim']					== 'NULL' else None
  proctranslimit_waarde	= 0 if row['proctranslimit']		== 'NULL' else None


# gedeeltelijk om fout te zoeken
# gaat goed: [punchoutcode] t/m [longname] + cmpcode
#
# ToDo
# Werkwijze :::::::::::::::::::::::::::::::::::::::
# Voeg iedere keer 1 nieuwe kolom toe vanaf cmpcode
  cursor.execute("INSERT INTO [codafin12].[oas_element](\
	                [cmpcode]\
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
					  ?,?,?,?,?,?,?,?,?,?,\
					  ?,?,?,?,?,?,?,?,?,?,\
					  ?,?,?,?,?,?,?,?,?,?,\
					  ?,?,?,?,?,?,?,?,?,?,\
					  ?,?,?,?,?,?,?,?,\
					  ?,?,?,?,?,\
			          ?,?,?\
                 )",
	                row['cmpcode']

				   #letop niet varchar velden, gebruik variable *_waarde ipv row['..']
                   ,row['paymentindex']
                   ,taxadjustment_waarde
                   ,matchtopo_waarde
                   ,row['extval']
				   ,arcpaid_waarde
                   ,arcrecon_waarde
				   ,row['ten99code']
				   ,subslevel_waarde
				   ,row['subselm']
				   ,temporaryelm_waarde
				   ,maxtemporaryid_waarde
                   ,allowtaxnum_waarde
                   ,allowlangcode_waarde
                   ,allowctycode_waarde
                   ,forceterms_waarde
                   ,forcetaxnum_waarde
                   ,forceaddress_waarde
                   ,force1099_waarde
                   ,startyear_waarde
                   ,startperiod_waarde
                   ,endyear_waarde
                   ,endperiod_waarde
                   ,row['statmemo']
				   ,row['balancingacc']
				   ,row['catcode']
				   ,assetelement_waarde
				   ,row['extcode']
				   ,extconfig_waarde
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
	               ,punchoutenc_waarde
	               ,punchoutmktplace_waarde
	               ,custsuppaccext_waarde
	               ,autoreceipt_waarde
	               ,procstatus_waarde
	               ,tolerancecode_waarde
	               ,matchingoffset_waarde
	               ,proctranslimit_waarde
				   ,proctranslimit_dp_waarde
	               ,row['proccalloffs']
	               ,row['procgrns']
	               ,row['procreturns']
	               ,row['procemailsal']
	               ,row['procemailsub']
	               ,row['euvatcode']
	               ,row['longname'])


'''
# volledige aan gepast  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# niet aan komen  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  cursor.execute("INSERT INTO [codafin12].[oas_element](\
	                [cmpcode]\
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

				   ,cmpcode_cs_waarde ###
	               ,row['code']
	               ,code_cs_waarde ###
	               ,elmlevel_waarde
	               ,elmlevel_cs_waarde ###
	               ,row['indirectcode']
	               ,tstamp_waarde
	               ,row['name']
	               ,row['sname']
	               ,row['cur']
	               ,row['tax']
	               ,accounttype_waarde
	               ,row['statuser']
	               ,statpay_waarde
	               ,statrec_waarde
	               ,descr_waarde
	               ,matchable_waarde
	               ,statpayint_waarde ###
	               ,summary_waarde
	               ,split_waarde
	               ,row['settle']
	               ,paper_waarde
	               ,elec_waarde
	               ,subanal_waarde
	               ,taxrepesl_waarde
	               ,taxrepintra_waarde
	               ,crliminforce_waarde
	               ,crlim_waarde
	               ,crlim_dp_waarde
	               ,taxmethod_waarde
	               ,row['terms']
	               ,keepturn_waarde
	               ,ten99_waarde
	               ,custsuppacc_waarde
	               ,discenable_waarde
	               ,forcedisperse_waarde
	               ,enablepay_waarde
	               ,row['paymode']
	               ,priority_waarde
	               ,row['medcode']
	               ,tag_waarde
	               ,qty1_used_waarde
	               ,row['qty1_title']
	               ,qty1_mand_waarde
	               ,row['qty1_balcode']
	               ,qty1_dp_waarde
	               ,qty2_used_waarde
	               ,row['qty2_title']
	               ,qty2_mand_waarde
	               ,row['qty2_balcode']
	               ,qty2_dp_waarde
	               ,qty3_used_waarde
	               ,row['qty3_title']
	               ,qty3_mand_waarde
	               ,row['qty3_balcode']
	               ,qty3_dp_waarde
	               ,qty4_used_waarde
	               ,row['qty4_title']
	               ,qty4_mand_waarde
	               ,row['qty4_balcode']
	               ,qty4_dp_waarde
	               ,row['adddate']
	               ,row['moddate']
	               ,row['deldate']
	               ,row['usrname']
	               ,row['accountsummary']
	               ,row['crlimdate']
	               ,crlimcurr_waarde
	               ,row['elmstat']
	               ,row['sic']
	               ,row['crmanager']
	               ,row['crrating']
	               ,row['crratingdate']
	               ,row['crref']
	               ,row['cragency']
	               ,row['dateaccopened']
	               ,row['paymentindex']
	               ,taxadjustment_waarde
	               ,matchtopo_waarde
	               ,row['extval']
	               ,arcpaid_waarde
	               ,arcrecon_waarde
	               ,row['ten99code']
	               ,subslevel_waarde
	               ,row['subselm']
	               ,temporaryelm_waarde
	               ,maxtemporaryid ###
	               ,allowtaxnum_waarde
	               ,allowlangcode_waarde
	               ,allowctycode_waarde
	               ,forceterms_waarde
	               ,forcetaxnum_waarde
	               ,forceaddress_waarde
	               ,force1099_waarde
	               ,startyear_waarde
	               ,startperiod_waarde
	               ,endyear_waarde
	               ,endperiod_waarde
	               ,row['statmemo']
	               ,row['balancingacc']
	               ,row['catcode']
	               ,assetelement_waarde
	               ,row['extcode']
	               ,extconfig_waarde
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
	               ,punchoutenc_waarde
	               ,punchoutmktplace_waarde
	               ,custsuppaccext_waarde
	               ,autoreceipt_waarde
	               ,procstatus_waarde
	               ,tolerancecode_waarde
	               ,matchingoffset_waarde
	               ,proctranslimit_waarde
	               ,proctranslimit_dp_waarde
	               ,row['proccalloffs']
	               ,row['procgrns']
	               ,row['procreturns']
	               ,row['procemailsal']
	               ,row['procemailsub']
	               ,row['euvatcode']
	               ,row['longname'])
'''


# hieronder bewaren   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# bevat de volledige set kolommen !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'''
  cursor.execute("INSERT INTO [codafin12].[oas_element](\
	                [cmpcode]\
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
'''                  
sql_conn.commit() 
cursor.close() 
sql_conn.close() 


print("Einde verwerking")
