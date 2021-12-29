use [TestStagingDB4]
go

truncate table [dbo].[Medewerker4];
go
truncate table [dbo].[Organisatie_Eenheid4];
go


insert into Organisatie_Eenheid4
( 
  -- gegenereerde Hashkey obv business key tbv de Hub
    hashkey
  -- surrogate key 
  ,[id]
  -- Busness key
  ,[code]
  -- Properties
  ,[naam]
  -- Meta gegevens
  ,[meta_record_source]
  ,[meta_load_date]
  ,[meta_create_time]
)
select 
      -- gegenereerde Hashkey obv business key tbv de Hub
      -- SHA2_256 geeft 32 bits key
       HASHBYTES('SHA2_256', [code]) as hashkey
      -- surrogate key 
      ,[id]
      -- Busness key
      ,[code]
      -- Properties
      ,[naam]
      -- Meta gegevens
      ,'fictief' as [meta_record_source]
	    ,convert(date, getdate()) as [meta_load_date]
	    ,convert(time, getdate()) as [meta_create_time]
from [TestSourceDB4].[dbo].[Organisatie_Eenheid4];
go


insert into [Medewerker4]
(
   -- gegenereerde Hashkey obv business key tbv de Hub
   hashkey
  -- surrogate key 
  ,[id]
  -- Busness key
  ,[nr]
  -- Properties
  ,[voorletters]
  ,[voorvoegsel]
  ,[achternaam]
  ,[geboortedatum]
  ,[aow_datum]
  ,[werkt_voor_org_eenheid]
  ,[hoogste_opleiding]
  ,[bril_dragend]
  ,[schoenmaat]
  -- Meta gegevens
  ,[meta_record_source]
  ,[meta_load_date]
  ,[meta_create_time]
)
select 
      -- gegenereerde Hashkey obv business key tbv de Hub
      -- SHA2_256 geeft 32 bits key
       HASHBYTES('SHA2_256', [nr]) as hashkey
	    ,[id]
      -- Business key
      ,[nr]
      -- Properties
      ,[voorletters]
      ,[voorvoegsel]
      ,[achternaam]
      ,[geboortedatum]
      ,[aow_datum]
      ,[werkt_voor_org_eenheid]
      ,[hoogste_opleiding]
      ,[bril_dragend]
      ,[schoenmaat]
      -- Meta gegevens
      ,'fictief' as [meta_record_source]
	    ,convert(date, getdate()) as [meta_load_date]
	    ,convert(time, getdate()) as [meta_create_time]
from [TestSourceDB4].[dbo].[Medewerker4];
go
