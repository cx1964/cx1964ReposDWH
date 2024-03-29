USE [master]
GO

CREATE LOGIN [myTestDBOwnerSource]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerStaging]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerIntegration]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO

CREATE LOGIN [myTestDBOwnerPresentation]
WITH PASSWORD=N'Welkom01' 
     -- MUST_CHANGE
    ,DEFAULT_DATABASE=[master]
     --,CHECK_EXPIRATION=ON
     --,CHECK_POLICY=ON
GO