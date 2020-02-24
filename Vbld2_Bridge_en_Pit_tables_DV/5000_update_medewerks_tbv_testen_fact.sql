-- tbv test AOW datum
-- Geef medewerker een reeele geboortedatum
update TestSourceDB2.dbo.Medewerker2
set geboortedatum = '19250531'
where nr = '000010';

-- Geef medewerker een bijpassende AOW_Datum in het verleden
update TestSourceDB2.dbo.Medewerker2
set aow_datum = '19900531'
where nr = '000010';
