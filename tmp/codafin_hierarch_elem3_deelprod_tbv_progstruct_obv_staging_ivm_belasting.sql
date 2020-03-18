-- Filenaam: codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_staging_ivm_belasting.sql
-- Functie: query deelproduct hierarchie tbv programmastructuur 
--          query omgeboud van bron op staging database DWH zodat bron net wordt belast
--          Deze query gebrukt staging DWH

-- use codafin
use DWH_STG;
go

-- check ook de queries in SSRS rapporten
-- Referentie DWH sem.SV_DEELPRODUCT

-- vergelijk uitkomst van deze query met queryMajidProgrammaHierarchieElement3.sql

select  
        himlist.code [hierarchiecode] 
       ,himlist.l1name [programma_code] 
       ,himlist.l1hdrtxt [programma_omschrijving] 
       ,himlist.l2name AS [doel_code] 
       ,himlist.l2hdrtxt [doel_omschrijving] 
       ,himlist.l3name [taak_code] 
       ,himlist.l3hdrtxt [taak_omschrijving] 
       ,himlist.leafname [product_code] 
       ,himlist.leafhdrtxt [product_omschrijving] 
       ,element.code [deelproduct_code]  -- <<---------------
       ,element.name [deelproduct_omschrijving]
       ,element.code AS [deelproduct2024] -- <<---------------
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
  and himlist.code = 'PZHPROG2024' -- bepaalt welke programmabegroting voor welke collegeperiode
order by himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go
-- @ 20200318 2359 rows
