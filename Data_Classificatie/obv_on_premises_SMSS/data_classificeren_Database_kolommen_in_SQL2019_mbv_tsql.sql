-- file: data_classificeren_Database_kolommen_in_SQL2019_mbv_tsql.sql

-- zie ook evernote: zie ook How To Opvragen van de data geclassificeerde Database kolommen in een SQL database

-- Functie: data classificeren van Database kolommen in een SQL2019 database mbv t-sql 
-- Doc: https://docs.microsoft.com/en-us/sql/t-sql/statements/add-sensitivity-classification-transact-sql?view=sql-server-ver15&WT.mc_id=DP-MVP-5001259

-- A. Classifying two columns 
-- 
-- The following example classifies the columns dbo.sales.price and dbo.sales.discount with 
-- the sensitivity label Highly Confidential, rank Critical and the Information Type Financial. 
ADD SENSITIVITY CLASSIFICATION TO 
    dbo.sales.price, dbo.sales.discount 
    WITH ( LABEL='Highly Confidential', INFORMATION_TYPE='Financial', RANK=CRITICAL )

-- B. Classifying only a label 
-- 
-- The following example classifies the column dbo.customer.comments with the label Confidential 
-- and label ID 643f7acd-776a-438d-890c-79c3f2a520d6. Information type isn't classified for this column. 
ADD SENSITIVITY CLASSIFICATION TO 
    dbo.customer.comments 
    WITH ( LABEL='Confidential', LABEL_ID='643f7acd-776a-438d-890c-79c3f2a520d6' )

