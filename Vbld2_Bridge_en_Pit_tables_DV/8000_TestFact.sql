use [TestPresentationDB2]
go

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
