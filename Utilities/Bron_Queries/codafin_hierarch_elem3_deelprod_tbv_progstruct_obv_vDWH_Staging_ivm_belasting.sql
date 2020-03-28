-- Filenaam: codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_vDWH_Staging_ivm_belasting.sql
-- Functie:  Query deelproduct hierarchie tbv programmastructuur 
--           Query omgebouwd van bron op staging database vDWH zodat bron niet wordt belast
--           Deze query gebrukt staging vDWH
-- Referenties: Codalive SSRS rapport Informatieportaal productie CI40826 "CODA Element 3 programmastructuur 2020-2024" zoals op 20200325 op informatieportaal
--              Codalive SSRS rapport Informatieportaal productie CI40826 "0078b Element 3 programmastructuur 2016-2019" 
--              Query van Semantische view uit Semlaag DWH: sem.SV_DEELPRODUCT
-- Opmerking: Deze query geeft voor gegeven test situatie (himlist.l3name = '9-1-1')
--            evenveel records op voor zelfde testcase als in SSRS rapport 
--            CI40826 "CODA Element 3 programmastructuur 2020-2024".rdl en
--            CI40826 "0078b Element 3 programmastructuur 2016-2019".rdl
--            De query met exact even veel records opleveren als query codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_DWH_STG_ivm_belasting.sql

-- use codafin
-- use DWH_STG;
use [vDWH_Staging];
go


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
       -- uit SSRS rapport "0078b Element 3 programmastructuur 2016-2019.rdl" gehaald
       ,case
          when year(getdate()) * 10000 + month(getdate())
            between 
              --(case when Prog.startyear &gt; 0 then Prog.startyear else 1900 end * 10000 + Prog.startperiod)
              (case when element.startyear > 0 then element.startyear else 1900 end * 10000 + element.startperiod)
              and
              --(case when Prog.endyear &gt; 0 then Prog.endyear else 9999 end * 10000 + Prog.endperiod)
              (case when element.endyear > 0 then element.endyear else 9999 end * 10000 + element.endperiod)
          then ('ja')
          else ('nee')
        end as geldig
-- from codafin.dbo.oas_element element
-- from dwh_stg.codafin12.oas_element element
from vDWH_Staging.coda.load_oas_element element
-- left join codafin.dbo.oas_grplist grplist
-- inner join dwh_stg.codafin12.oas_grplist grplist
inner join vDWH_Staging.coda.load_oas_grplist grplist
      on (
          element.cmpcode  = grplist.cmpcode
      and element.code     = grplist.code
      and element.elmlevel = grplist.elmlevel
      )
-- inner join codafin.dbo.oas_himlist himlist
-- inner join dwh_stg.codafin12.oas_himlist himlist
inner join vDWH_Staging.coda.load_oas_himlist himlist
      on (
          himlist.cmpcode = grplist.cmpcode
      and himlist.grpcode = grplist.grpcode     
      )     
where 1=1
  and element.elmlevel = 3 -- deelproduct
  and grplist.elmlevel = 3 -- extra conditie uit rapport  CI40826 0078b Element 3 programmastructuur 2016-2019.rdl
  and element.cmpcode  = 'PZH'
  and himlist.code     = 'PZHPROG2024' -- bepaalt welke programmabegroting voor welke collegeperiode
  and
       -- substitutie variabelen tbv
       -- geldigheidscheck: geldig = 'ja'
       ( case
          when year(getdate()) * 10000 + month(getdate())
            between 
              --(case when Prog.startyear &gt; 0 then Prog.startyear else 1900 end * 10000 + Prog.startperiod)
              (case when element.startyear > 0 then element.startyear else 1900 end * 10000 + element.startperiod)
              and
              --(case when Prog.endyear &gt; 0 then Prog.endyear else 9999 end * 10000 + Prog.endperiod)
              (case when element.endyear > 0 then element.endyear else 9999 end * 10000 + element.endperiod)
          then ('ja')
          else ('nee')
        end ) = 'ja'
  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  -- and himlist.l3name = '9-1-1' -- beleidsprestatiecode

order by himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go

