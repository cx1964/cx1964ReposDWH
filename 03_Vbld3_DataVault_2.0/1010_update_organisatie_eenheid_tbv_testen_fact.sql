-- tbv test AOW datum
use [TestPresentationDB3];
go

update TestSourceDB3.dbo.[Organisatie_Eenheid3]
set naam = naam + ' ***'
where code = '46300';

update TestSourceDB3.dbo.[Organisatie_Eenheid3]
set naam = naam + ' ***'
where code = '46500';


