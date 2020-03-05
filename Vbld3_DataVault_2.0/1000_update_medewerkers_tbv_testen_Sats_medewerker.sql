use [TestSourceDB3];
go

update TestSourceDB3.dbo.Medewerker3
set schoenmaat = 47
where nr = '000010';
go

