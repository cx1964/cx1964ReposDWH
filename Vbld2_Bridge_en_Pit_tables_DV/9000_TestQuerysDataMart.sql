use [TestPresentationDB2]
go

-- test resultaat van DataMart

SELECT 
       oe.[code]
      ,oe.[naam]
      ,[aantal_gepensioneerden]
      ,f.[meta_record_source]
      ,f.[meta_load_date]
      ,f.[meta_create_time]
  FROM [TestPresentationDB2].[dbo].[FACT_gepensioneerde_per_OE] f
  INNER JOIN [dbo].[Dim_Organisatie_Eenheid] oe
             on oe.H_Organisatie2HashKey = f.H_Organisatie2HashKey
  order by oe.code
go


-- bron data
select  m.nr
       ,m.achternaam
	   ,m.voorvoegsel
	   ,m.voorletters
	   ,m.geboortedatum
	   ,m.aow_datum
	   ,oe.code            as organisatie_code
	   ,oe.naam            as organisatie_naam
from [TestSourceDB2].dbo.Medewerker2 m
LEFT JOIN [TestSourceDB2].dbo.Organisatie_Eenheid2 oe
     on oe.id = m.werkt_voor_org_eenheid
order by oe.code
go
