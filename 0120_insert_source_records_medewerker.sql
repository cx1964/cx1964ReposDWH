use [TestSourceDB]
go

truncate table [dbo].[medewerker] 
go

insert [dbo].[medewerker] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid]) values ('000010', 'P.', null, 'Paaltjes', '19620101', '20290101', 5);
insert [dbo].[medewerker] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid]) values ('000020', 'J.', null, 'Klaassen', '19680101', '20350101', 5);

insert [dbo].[medewerker] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid]) values ('000030', 'M.', 'van de', 'Berg', '19720101', '20390101', 6);
GO
