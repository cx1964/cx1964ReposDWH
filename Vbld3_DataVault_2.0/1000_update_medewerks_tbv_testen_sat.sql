use [TestSourceDB3];
go

update TestSourceDB3.dbo.Medewerker3
set schoenmaat = schoenmaat + 1
where nr = '000010';
go

