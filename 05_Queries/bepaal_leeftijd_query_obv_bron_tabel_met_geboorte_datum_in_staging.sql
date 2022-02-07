select top 1  
       dwh_stg.pv59.rep_personalia.NAAM 
      ,cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date) as geboorte_datum
      /* 
      ,DATEDIFF ( year 
                 ,cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date)  
                 ,cast(getdate() as date) 
                )
      */
      /*          
     ,DATEDIFF ( year 
                 ,cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date)  
                 ,cast(getdate() as date) 
                )  - 1  
      */          
      --,right('00'+cast(month(cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date) ) as varchar(2)),2) as maand_str
      --,right('00'+cast(day  (cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date) ) as varchar(2)),2) as dag_str
      -- ,cast(year (cast(getdate()                               as date) ) as varchar(4)) as jaar_str
      /*
      ,cast(
         cast(datepart(year, cast(getdate()                               as date) ) as varchar(4)) +
         right('00'+cast(month(cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date) ) as varchar(2)), 2) +
         right('00'+cast(day(cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT      as date) ) as varchar(2)),2) as date
       ) as hulp_datum
      */    
      ,case 
          when
               -- test of systeemdatum < (geboorte_dag + geboorde_datum +jaar(systeemdatum)) 
               cast(getdate() as date) < cast(
              cast(datepart(year, cast(getdate()                               as date) ) as varchar(4)) +
              right('00'+cast(month(cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date) ) as varchar(2)), 2) +
              right('00'+cast(day(cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT      as date) ) as varchar(2)),2) as date
            ) -- test sysdate  < hulp_datum
          then
             --- nog niet jarig geweest in het jaar
             DATEDIFF ( year 
                       ,cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date)  
                       ,cast(getdate() as date) 
             )  - 1   
          else 
             -- jarig geweest in het jaar
             DATEDIFF ( year 
                       ,cast(dwh_stg.pv59.rep_personalia.GEBOORTEDAT as date)  
                       ,cast(getdate() as date) 
             )    
        end as correcte_leeftijd                    
      ,cast(getdate() as date) as systeem_datum
from dwh_stg.pv59.rep_personalia 
where naam like '%de Waerd'
