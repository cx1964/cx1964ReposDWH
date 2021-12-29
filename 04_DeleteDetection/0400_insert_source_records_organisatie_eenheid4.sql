use [TestSourceDB4]
go


-- verwijder FK tussen Medewerker en Organisatie_eenheid tbv l
ALTER TABLE [dbo].[Medewerker4]
DROP CONSTRAINT [FK_Medewerker_Organisatie_Eenheid4];
GO

truncate table [dbo].[Organisatie_Eenheid4]
go

insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (40000, 'Directie Concernzaken');

insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (46000, 'Afdeling Informatisering en Automatisering');

insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (46300, 'Bureau Advies en Beleid');
insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (46400, 'Bureau Bedrijfsinformatie');
insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (46500, 'Bureau Infrastructuur en Support');
insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (46700, 'Bureau Documentaire Informatie');

insert [dbo].[Organisatie_Eenheid4] ([code],[naam]) values (45000, 'Afdeling Financiële en Juridische Zaken');

GO


-- aanzetten FK tussen Medewerker en Organisatie_eenheid tbv laden
ALTER TABLE [dbo].[Medewerker4]
ADD CONSTRAINT FK_Medewerker_Organisatie_Eenheid4
    FOREIGN KEY (werkt_voor_org_eenheid)
            REFERENCES Organisatie_Eenheid4 (id)
GO

-- count inserted records
select count(*) as aantal_records_Organisatie_Eenheid4 
from [dbo].[Organisatie_Eenheid4]
go 