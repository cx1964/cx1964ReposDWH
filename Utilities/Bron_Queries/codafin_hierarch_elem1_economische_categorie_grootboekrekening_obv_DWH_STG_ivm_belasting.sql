-- Filenaam: codafin_hierarch_elem1_economische_categorie_grootboekrekening_obv_DWH_STG_ivm_belasting.sql
-- Functie:  query economische categorie (grootboekrekening) hierarchie
--           Deze query gebrukt staging DWH
--           output vergeleken met ssrs rapport CI40942 "CODA Element 1 Hierarchie economische categorie"
--           20200325 Obv van een steekproef van 5 metingen klopt de query in vergelijk met het ssrs rapport

-- use codafin
use DWH_STG;
go

-- ToDo nog testen op volledigheid van de gegevens

select  
        himlist.code as [hierarchiecode] 
       ,himlist.l1name as [hoofd_knooppunt_code] 
       ,himlist.l1hdrtxt as [hoofd_knooppunt]   
       ,himlist.l2name as [l2name]              -- niet gebruikt
       ,himlist.l2hdrtxt as [l2hdrtxt]    -- niet gebruikt
       ,himlist.l3name as [l3name]               -- niet gebruikt
       ,himlist.l3hdrtxt as [l3hdrtxt]           -- niet gebruikt 
       ,himlist.leafname  as [economische_categorie_code] 
       /* ,himlist.leafhdrtxt as [economische_categorie] */
       ,grp.sname as [economische_categorie]
       ,grp.name as [economische_categorie_naam]
       ,element.code as [grootboekrekening_nummer]  
       ,element.name as [grootboekrekening_naam]
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
-- extra       
inner join dwh_stg.codafin12.oas_group grp
       on (
           grp.cmpcode   = grplist.cmpcode
       and grp.groupwhat = grplist.elmlevel
       and grp.code      = grplist.grpcode
       )
where 1=1
  and element.elmlevel = 1 -- economische catgeorie (grootboekrekening)
  and himlist.code = 'PZHECOCAT' -- bepaalt welke kostenplaats hierarchie wordt gebruikt

  -- tbv test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- and element.code = '00101'     -- grootboekrekeningnummer
  -- and grp.sname = '1.0.1'  -- economische_categorie 20200325 klopt
  -- and grp.sname = '2.1'    -- economische_categorie 20200325 klopt
  -- and grp.sname = '6.0'    -- economische_categorie 20200325 klopt
  -- and grp.sname = '7.7'    -- economische_categorie 20200325 klopt
  -- and grp.sname = '8.2'    -- economische_categorie 20200325 klopt


order by 
         element.code;
go

-- select *
-- from dwh_stg.codafin12.oas_group as grp -- group is reserverd word !
