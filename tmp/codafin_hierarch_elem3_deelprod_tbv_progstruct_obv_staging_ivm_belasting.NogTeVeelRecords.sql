-- Filenaam: codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_staging_ivm_belasting.sql
-- Functie: query deelproduct hierarchie tbv programmastructuur 
--          query omgebouwd van bron op staging database DWH zodat bron net wordt belast
--          Deze query gebrukt staging DWH

-- use codafin
use DWH_STG;
go

-- ToDo

-- Nog vergelijken met:
-- 1. Codalive SSRS rapport Informatieportaal productie
-- 2. vergelijk uitkomst van deze query met queryMajidProgrammaHierarchieElement3.sql

-- check ook de queries in SSRS rapporten
-- Referentie DWH sem.SV_DEELPRODUCT

-- nog te veel records !!!

-- weg halen test condities !!!!!!!!!
select  
        himlist.code as [hierarchiecode] 
       ,himlist.l1name as [programma_code_alias_ambitie_code] 
       ,himlist.l1hdrtxt as [programma_omschrijving_alias_ambitie] 
       ,himlist.l2name as [doel_code_alias_beleidsdoelcode] 
       ,himlist.l2hdrtxt as [doel_omschrijving_alias_beleidsdoel] 
       ,himlist.l3name as [taak_code_alias_beleidsprestatiecode] 
       ,himlist.l3hdrtxt as [taak_omschrijving_alias_beleidsprestatie] 
       ,himlist.leafname  as [product_code_alias_productcode] 
       ,himlist.leafhdrtxt as [product_omschrijving_alias_productnaam] 
       ,element.code as [deelproduct_code_alias_deelproductcode]  -- <<---------------
       ,element.name as [deelproduct_omschrijving_alias_deelproductnaam]
       -- uit SSRS rapport gehaald
       /***
       ,case
          when year(getdate()) * 10000 + month(getdate())
               between 
                  (case when Prog.startyear &gt; 0 then Prog.startyear else 1900 end * 10000 + Prog.startperiod)
                  and
                  (case when Prog.endyear &gt; 0 then Prog.endyear else 9999 end * 10000 + Prog.endperiod)
          then ('ja')
          else ('nee')
        end as geldig
        ***/
-- from codafin.dbo.oas_element element
from dwh_stg.codafin12.oas_element element
-- left join codafin.dbo.oas_grplist grplist
inner join dwh_stg.codafin12.oas_grplist grplist
      on (
          element.cmpcode  = grplist.cmpcode
      and element.code     = grplist.code
      and element.elmlevel = grplist.elmlevel
      )
--inner join codafin.dbo.oas_himlist himlist
inner join dwh_stg.codafin12.oas_himlist himlist
      on (
          himlist.cmpcode = grplist.cmpcode
      and himlist.grpcode = grplist.grpcode     
      )     
where 1=1
  and element.elmlevel = 3 -- deelproduct
  and grplist.elmlevel = 3 -- extra conditie uit rapport  CI40826 0078b Element 3 programmastructuur 2016-2019.rdl
--  and element.cmpcode  = 'PZH'
--  and himlist.code     = 'PZHPROG2024' -- bepaalt welke programmabegroting voor welke collegeperiode
  and himlist.code     = 'PZHPROG1620' -- tbv test 


-- Dit levert wel records op op ph429 @ 20200325
-- select *
-- from dwh_stg.codafin12.oas_himlist himlist
-- where himlist.code     = 'PZHPROG1620' 








  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  --and himlist.l1name = '9'     -- ambitiecode
  and himlist.l3name = '9-1-1' -- beleidsprestatiecode

order by himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go
-- @ 20200318 2359 rows
