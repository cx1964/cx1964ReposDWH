use [TestSourceDB3];
go

update TestSourceDB3.dbo.Medewerker3
set schoenmaat = 48
where nr = '000010';
go

update TestSourceDB3.dbo.Medewerker3
set aow_datum = '19900701'
where nr = '000010';
go
