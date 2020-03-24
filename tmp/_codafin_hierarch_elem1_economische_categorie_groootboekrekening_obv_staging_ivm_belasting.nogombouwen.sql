-- Filenaam: _codafin_hierarch_elem1_economische_categorie_groootboekrekening_obv_staging_ivm_belasting.nogombouwen.sql
-- Functie: query economische categorie (grootboekrekening) hierarchie
--          query omgebouwd van bron op staging database DWH zodat bron net wordt belast
--          Deze query gebrukt staging DWH
--          output vergeleken met ssrs rapport CI40942 "CODA Element 1 Hierarchie economische categorie"

-- use codafin
use DWH_STG;
go

-- ToDo anders sortren om te vergelijk met rapport

select  
        himlist.code as [hierarchiecode] 
       ,himlist.l1name as [organisatie_eenheid_code] 
       ,himlist.l1hdrtxt as [organisatie_eenheid_naam] 
       ,himlist.l2name as [afdelings-code] 
       ,himlist.l2hdrtxt as [afdelings-naam] 
       ,himlist.l3name as [l3name]               -- niet gebruikt
       ,himlist.l3hdrtxt as [l3hdrtxt]           -- niet gebruikt 
       ,himlist.leafname  as [bureau-code] 
       ,himlist.leafhdrtxt as [bureau-naam] 
       ,element.code as [kostenplaats_code]  
       ,element.name as [kostenplaats_naam]
       ,case
          when element.endyear = '0' 
          then 'ja'
          else 'nee'
        end as geldig --  klopt dit ??????????????????
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
  and element.elmlevel = 1 -- economische catgeorie (grootboekrekening)
  and himlist.code = 'PZHECOCAT' -- bepaalt welke kostenplaats hierarchie wordt gebruikt

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- and himlist.l2name = 'A2107'     -- afdeingscode

order by 
         himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go

/*
select  distinct
        himlist.code as [hierarchiecode] 
       ,case
          when element.endyear = '0' 
          then 'ja'
          else 'nee'
        end as geldig --  klopt dit ??????????????????
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
  and element.elmlevel = 1 -- economische catgeorie (grootboekrekening)
--  and himlist.code = 'PZHORG-D' -- bepaalt welke kostenplaats hierarchie wordt gebruikt

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- and himlist.l2name = 'A2107'     -- afdeingscode

order by 
         1;
go
*/
