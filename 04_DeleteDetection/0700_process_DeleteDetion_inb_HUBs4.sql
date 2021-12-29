-- Verwerk DeleteDetection in Raw DataVault
-- set meta_IsDeletedInSource = 'TRUE' voor records 
-- waarvan business key niet in de source voor komet AND wel in de HUB.


use [TestIntegrationDB4]
go

-- verwerk H_Organisatie_Eenheid4
UPDATE [TestIntegrationDB4].DBO.H_Organisatie_Eenheid4
SET meta_IsDeletedInSource = 'TRUE'
WHERE code /* business key */  in (
    -- Alle hub records die een business key in de hub hebben
    -- maar niet in de bron/staging
    SELECT code
    FROM [TestIntegrationDB4].[DBO].[H_Organisatie_Eenheid4]
    WHERE 1=1
      and meta_IsDeletedInSource = 'FALSE'
    EXCEPT
    SELECT code
    FROM [TestStagingDB4].[DBO].[Organisatie_Eenheid4]
    WHERE 1=1
)    


-- verwerk H_Medewerker4
UPDATE [TestIntegrationDB4].DBO.H_Medewerker4
SET meta_IsDeletedInSource = 'TRUE'
WHERE nr /* business key */ in (
    -- Alle hub records die een business key in de hub hebben
    -- maar niet in de bron/staging
    SELECT nr
    FROM [TestIntegrationDB4].[DBO].[H_Medewerker4]
    WHERE 1=1
      and meta_IsDeletedInSource = 'FALSE'
    EXCEPT
    SELECT nr
    FROM [TestStagingDB4].[DBO].[Medewerker4]
    WHERE 1=1
)    



-- Debug info
SELECT *
FROM [TestIntegrationDB4].[DBO].[H_Medewerker4] 
WHERE 1=1
  AND meta_IsDeletedInSource = 'TRUE'

SELECT *
FROM [TestIntegrationDB4].[DBO].[H_Organisatie_Eenheid4]
WHERE 1=1
  AND meta_IsDeletedInSource = 'TRUE'