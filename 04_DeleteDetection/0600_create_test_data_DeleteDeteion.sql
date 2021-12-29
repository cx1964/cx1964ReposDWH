-- Create Test data voor DeleteDetection
-- Gooi uit de brontabellen een bronrecord die al in de HUB zit

use [TestSourceDB4]
go

-- Delete Organisatie_Eenheid4 Record from source
DELETE
FROM [TestSourceDB4].DBO.Organisatie_Eenheid4
WHERE 1=1
  and code = '46300'


-- Delete H_Medewerker4 Record from source
DELETE
FROM [TestSourceDB4].DBO.Medewerker4
WHERE 1=1
  and nr = '000020'

-- Debug info
select *
from dbo.Medewerker4 

select *
from dbo.Organisatie_Eenheid4