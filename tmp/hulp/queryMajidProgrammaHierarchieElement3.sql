-- filenaam: queryMajidProgrammaHierarchieElement3.sql
-- Functie: query tbv Hierarchie op Coda Element3 tbv Programmahierarchie
--          Deze query gebruikt staging vDWH

-- vergelijk output van deze query met codafin_hierarch_elem3_deelprod_tbv_progstruct_obv_staging_ivm_belasting.sql

SELECT DISTINCT 
       OAS_HIMLIST.code [hierarchiecode], 
       OAS_HIMLIST.l1name [programma_code], 
       OAS_HIMLIST.l1hdrtxt [programma_omschrijving], 
       OAS_HIMLIST.l2name AS [doel_code], 
       OAS_HIMLIST.l2hdrtxt [doel_omschrijving], 
       OAS_HIMLIST.l3name [taak_code], 
       OAS_HIMLIST.l3hdrtxt [taak_omschrijving], 
       OAS_HIMLIST.leafname [product_code], 
       OAS_HIMLIST.leafhdrtxt [product_omschrijving], 
       OAS_ELEMENT.code [deelproduct_code], 
       OAS_ELEMENT.name [deelproduct_omschrijving],
       --,CONCAT(OAS_HIMLIST.l1name , ' - ', OAS_HIMLIST.l1hdrtxt)     AS 'programma_code + programma_omschrijving', 
       --CONCAT(OAS_HIMLIST.l2name , ' - ', OAS_HIMLIST.l2hdrtxt)     AS 'doel_code + doel_omschrijving', 
       --CONCAT(OAS_HIMLIST.l3name , ' - ', OAS_HIMLIST.l3hdrtxt)
       --AS 'taak_code + taak_omschrijving',
       --CONCAT(OAS_HIMLIST.leafname , ' - ', OAS_HIMLIST.leafhdrtxt) AS 'product_code + product_omschrijving',
       --CONCAT(OAS_ELEMENT.code , ' - ', OAS_ELEMENT.name) AS 'deelproduct_code + deelproduct_omschrijving', 
       OAS_ELEMENT.code AS [deelproduct2024]
FROM vDWH_Staging.coda.load_oas_himlist AS oas_himlist
     INNER JOIN vDWH_Staging.coda.load_oas_grplist AS oas_grplist ON OAS_HIMLIST.grpcode = OAS_GRPLIST.grpcode
                                                                     AND OAS_HIMLIST.cmpcode = OAS_GRPLIST.cmpcode
     INNER JOIN vDWH_Staging.coda.load_oas_element AS oas_element ON OAS_GRPLIST.code = OAS_ELEMENT.code
                                                                     AND OAS_GRPLIST.elmlevel = OAS_ELEMENT.elmlevel
                                                                     AND OAS_GRPLIST.cmpcode = OAS_ELEMENT.cmpcode
WHERE OAS_HIMLIST.code = 'PZHPROG2024';