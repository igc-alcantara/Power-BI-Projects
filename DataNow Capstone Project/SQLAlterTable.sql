USE FinancialReportingDB

-- altering table names for the star schema
EXEC sp_rename 'Sales Orders', 'FactSalesOrders';
GO

EXEC sp_rename 'Products', 'DimProducts';
GO

EXEC sp_rename 'Regions', 'DimRegions';
GO

EXEC sp_rename 'Customers', 'DimCustomers';
GO

-- dropping old tables
DROP TABLE [dbo].[Balance Sheet Data]
GO

DROP TABLE [dbo].[Cash Flow Data]
GO

DROP TABLE [dbo].[Company Expenses]
GO

-- adding primary keys to the tables
-- make sure column is not nullable
ALTER TABLE FactSalesOrders
ALTER COLUMN OrderNumber NVARCHAR(255) NOT NULL

ALTER TABLE FactSalesOrders
ADD CONSTRAINT pk_order_num PRIMARY KEY (OrderNumber);
GO

-- DimRegions
ALTER TABLE DimRegions
ALTER COLUMN [Index] INT NOT NULL

ALTER TABLE DimRegions
ADD CONSTRAINT pk_region_index PRIMARY KEY ([Index]);
GO

-- DimProducts
ALTER TABLE DimProducts
ALTER COLUMN [Index] INT NOT NULL

ALTER TABLE DimProducts
ADD CONSTRAINT pk_prod_index PRIMARY KEY ([Index]);
GO

-- DimCustomers
ALTER TABLE DimCustomers
ALTER COLUMN [Customer Index] INT NOT NULL

ALTER TABLE DimCustomers
ADD CONSTRAINT pk_customer_index PRIMARY KEY ([Customer Index]);
GO

-- Transaction Table
ALTER TABLE [dbo].[Transaction Table]
ALTER COLUMN [Invoice Number] NVARCHAR(255) NOT NULL

ALTER TABLE [dbo].[Transaction Table]
ADD CONSTRAINT pk_invoice_num PRIMARY KEY ([Invoice Number]);
GO

-- adding foreign keys
-- first match the foreign column to the primary column
ALTER TABLE FactSalesOrders
ALTER COLUMN [Delivery Region Index] INT NOT NULL
GO

ALTER TABLE FactSalesOrders
ALTER COLUMN [Product Description Index] INT NOT NULL
GO

ALTER TABLE FactSalesOrders
ALTER COLUMN [Customer Name Index] INT NOT NULL
GO

-- add foreign key constraints
ALTER TABLE FactSalesOrders
ADD CONSTRAINT fk_regions_sales
FOREIGN KEY ([Delivery Region Index])
REFERENCES DimRegions ([Index]);
GO

ALTER TABLE FactSalesOrders
ADD CONSTRAINT fk_product_sales
FOREIGN KEY ([Product Description Index])
REFERENCES DimProducts ([Index]);
GO

ALTER TABLE FactSalesOrders
ADD CONSTRAINT fk_regions_customer
FOREIGN KEY ([Customer Name Index])
REFERENCES DimCustomers ([Customer Index]);
GO

