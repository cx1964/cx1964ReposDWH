use [TestSourceDB]
go

-- Medewerker gaat voor anader OE werken
update [dbo].[medewerker]
set werkt_voor_org_eenheid = 3
where nr = '000020'

-- Update property van een medewerker
update [dbo].[medewerker]
set aow_datum = '20390101'
where nr = '000030'