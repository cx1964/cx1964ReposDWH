-- Filenaam: codafin_hierarch_elem4_dekkingsbron_obv_staging_ivm_belasting.sql
-- Functie: query dekkingsbron hierarchie
--          query omgebouwd van bron op staging database DWH zodat bron net wordt belast
--          Deze query gebrukt staging DWH
--          Output vergeleken met ssrs rapport CI40827 "CODA Element 4 hierarchie dekkingsbron 2020-2024"

-- use codafin
use DWH_STG;
go

select  
        himlist.code as [hierarchiecode]
       ,himlist.l1order as [volgorde1]] 
       ,himlist.l1name as [knooppunt1] 
       ,himlist.l1hdrtxt as [knooppunt1_koptekst]
       ,himlist.l2order as [volgorde2]]         
       ,himlist.l2name as [knooppunt2] 
       ,himlist.l2hdrtxt as [knooppunt2_koptekst] 
       ,himlist.l3name as [l3name]    -- niet gebruikt          
       ,himlist.l3hdrtxt as [l3hdrtxt]  -- niet gebruikt         
       ,himlist.leafname  as [groepcode]  
       ,himlist.leafhdrtxt as [groepnaam]  
       ,element.code as [dekkingsbron_code]  
       ,element.name as [dekkingsbron_naam]
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
  and element.elmlevel = 4-- kostenplaats
  and himlist.code = 'DEKBRON2024' -- bepaalt welke dekkingsbron hierarchie wordt gebruikt

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- and himlist.l1order = 3 

order by 
         himlist.l1order asc
        ,himlist.l1name
        ,himlist.l2order asc 
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go

