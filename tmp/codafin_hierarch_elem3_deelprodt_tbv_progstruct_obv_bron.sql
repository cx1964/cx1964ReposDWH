-- Filenaam: codafin_hierarchie_element3_deelproduct_tbv_programmastructuur
-- Functie: query deelproduct hierarchie tbv programmastructuur

use codafin
go


-- check ook de queries in SSRS rapporten
-- Referentie DWH sem.SV_KOSTENPLAATS

-- elm=2 kan ook crediteuren en debiteuren zijn

select     element.code,
           element.name,
           grplist.cmpcode,
           grplist.code,
           grplist.grpcode,
           CAST(himlist.code AS VARCHAR(20)) AS hierarchie,
           himlist.l1name,
           himlist.l1hdrtxt,
           himlist.l1order,
           himlist.l2name,
           himlist.l2hdrtxt,
           himlist.l2order,
           himlist.leafname,
           himlist.leafhdrtxt,
           himlist.leaforder
from codafin.dbo.oas_element element
left join codafin.dbo.oas_grplist grplist
      on (
          element.cmpcode  = grplist.cmpcode
      and element.code     = grplist.code
      and element.elmlevel = grplist.elmlevel
      )
inner join codafin.dbo.oas_himlist himlist
      on (
          himlist.cmpcode = grplist.cmpcode
      and himlist.grpcode = grplist.grpcode     
      )     
where 1=1
  and element.elmlevel = 3
go
