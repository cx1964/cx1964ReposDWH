-- Filenaam: codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_staging_ivm_belasting.sql
-- Functie: query deelproduct hierarchie tbv programmastructuur 
--          query omgebouwd van bron op staging database DWH zodat bron niet wordt belast
--          Deze query gebrukt staging DWH

-- use codafin
use DWH_STG;
go

-- ToDo

-- Nog vergelijken met:
-- 1. Codalive SSRS rapport Informatieportaal productie CI40826 "CODA Element 3 programmastructuur 2020-2024"

-- Referentie DWH sem.SV_DEELPRODUCT

-- nog afwijkend aantal records !!!

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
  and himlist.code     = 'PZHPROG2024' -- bepaalt welke programmabegroting voor welke collegeperiode
  --  and himlist.code     = 'PZHPROG1620' -- tbv test 

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  --and himlist.l1name = '9'     -- ambitiecode
  and himlist.l3name = '9-1-1' -- beleidsprestatiecode

order by himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go


-- query uit SSRS rapport "0078b Element 3 programmastructuur 2016-2019.rdl"
select
  Prog.l1name as ProgrammaCode,
  Prog.l1hdrtxt as ProgrammaNaam,
  Prog.l2name as DoelCode,
  Prog.l2hdrtxt as DoelNaam,
  Prog.l3name as TaakCode,
  Prog.l3order as Taakorder,
  Prog.l3hdrtxt as TaakNaam,
  Prog.leafname as ProductCode,
  Prog.leafhdrtxt as ProductNaam,
  Prog.code as DeelproductCode,
  Prog.name as DeelproductNaam,
  /*
  case
    when year(getdate()) * 10000 + month(getdate())
    between 
    (case when Prog.startyear &gt; 0 then Prog.startyear else 1900 end * 10000 + Prog.startperiod)
    and
    (case when Prog.endyear &gt; 0 then Prog.endyear else 9999 end * 10000 + Prog.endperiod)
    then ('ja')
    else ('nee')
  end
  as Geldig
  */
  case
    when year(getdate()) * 10000 + month(getdate())
    between 
    --(case when Prog.startyear &gt; 0 then Prog.startyear else 1900 end * 10000 + Prog.startperiod)
      (case when startyear > 0 then startyear else 1900 end * 10000 + startperiod)
    and
    --(case when Prog.endyear &gt; 0 then Prog.endyear else 9999 end * 10000 + Prog.endperiod)
      (case when endyear > 0 then endyear else 9999 end * 10000 + endperiod)
    then ('ja')
    else ('nee')
  end
  as Geldig
from
(select 
  oas_element.code  as  code,
  oas_element.name  as  name,
  oas_element.sname  as  sname,
  oas_grplist.grpcode  as  grpcode,
  oas_himlist.l1name  as  l1name,
  oas_himlist.l1hdrtxt  as  l1hdrtxt,
  oas_himlist.l2name  as  l2name,
  oas_himlist.l2hdrtxt  as  l2hdrtxt,
  oas_himlist.l3name  as  l3name,
  oas_himlist.l3order  as  l3order,
  oas_himlist.l3hdrtxt  as  l3hdrtxt,
  oas_himlist.leafname  as  leafname,
  oas_himlist.leafhdrtxt  as  leafhdrtxt,
  oas_element.endyear as endyear, 
  oas_element.endperiod as endperiod, 
  oas_element.startperiod as startperiod, 
  oas_element.startyear as startyear
from
  dwh_stg.codafin12.oas_element oas_element,
  dwh_stg.codafin12.oas_grplist oas_grplist,
  dwh_stg.codafin12.oas_himlist oas_himlist
where
  oas_element.elmlevel = 3 and
  oas_grplist.elmlevel = 3 and
  oas_grplist.cmpcode  = oas_himlist.cmpcode and
  oas_grplist.grpcode  = oas_himlist.grpcode and
  oas_element.code     = oas_grplist.code and
  oas_element.elmlevel = oas_grplist.elmlevel and
  oas_element.cmpcode  = oas_grplist.cmpcode and
  oas_element.cmpcode  = 'PZH' and
  -- oas_himlist.code     = 'PZHPROG1620'
  oas_himlist.code     = 'PZHPROG2024' and
  -- tbv test
  oas_himlist.l3name = '9-1-1' -- beleidsprestatiecode
) as Prog;
go