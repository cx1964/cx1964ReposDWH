-- File: 0010_create_db_owners4.sql
-- Functie: Owners voor voorbeeld4 DeleteDetection

USE [master]
GO

CREATE LOGIN [myTestDBOwnerSource4]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerStaging4]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerIntegration4]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerPresentation4]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO