-- Filenaam: codafin_hierarch_elem2_kostenplaats_obv_Local_Bron_ivm_belasting.sql
-- Functie: query kostenplaats hierarchie
--          Dit is een aangepaste versie van het werkende script
--          codafin_hierarch_elem2_kostenplaats_DWH_STG_staging_ivm_belasting.sql


-- use codafin
use [TestSourceDB3];
go

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
from TestSourceDB3.codafin12.oas_element element
-- left join codafin.dbo.oas_grplist grplist
inner join TestSourceDB3.codafin12.oas_grplist grplist
      on (
          element.cmpcode  = grplist.cmpcode
      and element.code     = grplist.code
      and element.elmlevel = grplist.elmlevel
      )
--inner join codafin.dbo.oas_himlist himlist
inner join TestSourceDB3.codafin12.oas_himlist himlist
      on (
          himlist.cmpcode = grplist.cmpcode
      and himlist.grpcode = grplist.grpcode     
      )     
where 1=1
  and element.elmlevel = 2 -- kostenplaats
  and himlist.code = 'PZHORG-D' -- bepaalt welke kostenplaats hierarchie wordt gebruikt

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- and himlist.l2name = 'A2107'     -- afdeingscode

order by 
         himlist.l1name
        ,himlist.l2name
        ,himlist.l3name
        ,himlist.leafname
        ,element.code;
go

