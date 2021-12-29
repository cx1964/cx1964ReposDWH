use [TestSourceDB4]
go

truncate table [dbo].[medewerker4] 
go

-- nog extra velden vullen
insert [dbo].[medewerker3] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid],[hoogste_opleiding],[bril_dragend],[schoenmaat]) values ('000010', 'P.', null    , 'Paaltjes', '19250531', '19900531', 5, 'WO' , 'J', 45);
insert [dbo].[medewerker3] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid],[hoogste_opleiding],[bril_dragend],[schoenmaat]) values ('000020', 'J.', null    , 'Klaassen', '19680101', '20350101', 5, 'HBO', 'N', 43);
insert [dbo].[medewerker3] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid],[hoogste_opleiding],[bril_dragend],[schoenmaat]) values ('000030', 'M.', 'van de', 'Berg'    , '19720101', '20390101', 6, 'MBO', 'J', 39);
insert [dbo].[medewerker3] ([nr],[voorletters],[voorvoegsel],[achternaam],[geboortedatum],[aow_datum],[werkt_voor_org_eenheid],[hoogste_opleiding],[bril_dragend],[schoenmaat]) values ('000040', 'M.', null    , 'Jansen'  , '19520325', '12120325', 6, 'HBO', 'J', 47);
GO



