jan weg


tbv queries

use [TestPresentationDB2]
go


select *
from TestStagingDB2.dbo.Organisatie_Eenheid2

SELECT *
from TestIntegrationDB2.dbo.S_Medewerker2_nvrtrw


-- hubs
select *
from TestIntegrationDB2.dbo.H_Medewerker2
select *
from TestIntegrationDB2.dbo.H_Organisatie_Eenheid2

-- LINKs
select *
from TestIntegrationDB2.dbo.L_Medewerker2_Organisatie_Eenheid2


tabel is leeg
-- SATs
select *
from TestIntegrationDB2.dbo.S_Medewerker2_nvrtrw
select *
from TestIntegrationDB2.dbo.S_Medewerker2_vrtrw
select *
from TestIntegrationDB2.dbo.S_Organisatie_Eenheid2