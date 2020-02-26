use [TestPresentationDB2]
go

-- geeft geen records
SELECT   d.code
        ,d.naam 
        ,f.aantal_gepensioneerden 
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
inner join TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
      on (     d.H_Organisatie2HashKey = f.H_Organisatie2HashKey
           and d.meta_load_date = f.meta_load_date
           and d.meta_create_time  = f.meta_create_time
           and d.meta_load_end_date = f.meta_load_end_date 
           and d.meta_create_end_time = f.meta_create_end_time 
         );


select d.H_Organisatie2HashKey
      ,d.meta_load_date
	  ,d.meta_create_time
	  ,d.meta_load_end_date
	  ,d.meta_create_end_time
	  ,d.code
FROM TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
where d.code = '46500' 
order by 1,2,3,4,5;
go

select f.H_Organisatie2HashKey
      ,f.meta_load_date
	  ,f.meta_create_time
	  ,f.meta_load_end_date
	  ,f.meta_create_end_time
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
order by 1,2,3,4,5;
go

SELECT   d.code
        ,d.naam 
        ,f.aantal_gepensioneerden
		,'toont nu wel records op join van deel van de kolommen'
FROM TestPresentationDB2.dbo.FACT_gepensioneerde_per_OE_Compleet f
inner join TestPresentationDB2.dbo.Dim_Organisatie_Eenheid_Compleet d
      on (     d.H_Organisatie2HashKey = f.H_Organisatie2HashKey
	       -- andere twee kolommen van de FK hebben nog niet correcte waarde
	       and d.meta_load_end_date = f.meta_load_end_date 
           and d.meta_create_end_time = f.meta_create_end_time 
         );
go

-- de problem kolommen in PK van DIM en FK van FACT zijn:
           --and d.meta_load_date = f.meta_load_date
           --and d.meta_create_time  = f.meta_create_time
