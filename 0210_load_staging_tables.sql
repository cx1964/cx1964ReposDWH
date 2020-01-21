use [TestStagingDB]
go

truncate table [dbo].[Medewerker];
go
truncate table [dbo].[Organisatie_Eenheid];
go

insert into Organisatie_Eenheid
(  [id]
  ,[code]
  ,[naam]
  ,[meta_record_source]
  ,[meta_load_date]
  ,[meta_create_time]
)
select 
       [id]
      ,[code]
      ,[naam]
      ,'fictief' as [meta_record_source]
	  ,convert(date, getdate()) as [meta_load_date]
	  ,convert(time, getdate()) as [meta_create_time]
from [TestSourceDB].[dbo].[Organisatie_Eenheid];
go


insert into [Medewerker]
(
   [id]
  ,[nr]
  ,[voorletters]
  ,[voorvoegsel]
  ,[achternaam]
  ,[geboortedatum]
  ,[aow_datum]
  ,[werkt_voor_org_eenheid]
  ,[meta_record_source]
  ,[meta_load_date]
  ,[meta_create_time]
)
select 
	   [id]
      ,[nr]
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
      ,[werkt_voor_org_eenheid]
      ,'fictief' as [meta_record_source]
	  ,convert(date, getdate()) as [meta_load_date]
	  ,convert(time, getdate()) as [meta_create_time]
from [TestSourceDB].[dbo].[Medewerker];
go
