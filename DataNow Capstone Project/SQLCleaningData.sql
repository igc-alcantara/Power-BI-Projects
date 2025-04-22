-- Capstone Project DataNow
-- Ian Gabriel C. Alcantara

USE FinancialReportingDB

-- dropping null columns
ALTER TABLE [dbo].['Balance Sheet Data$'] DROP COLUMN [F9]
      ,[F10]
      ,[F11]
      ,[F12]
      ,[F13]
      ,[F14]
      ,[F15]
      ,[F16]
      ,[F17]
      ,[F18]
      ,[F19]
      ,[F20]
      ,[F21]
      ,[F22]
      ,[F23]
      ,[F24]
      ,[F25]
      ,[F26]
      ,[F27]
      ,[F28]
      ,[F29]
      ,[F30]
      ,[F31]
      ,[F32]
      ,[F33]
      ,[F34]
      ,[F35]
      ,[F36]
      ,[F37]
      ,[F38]
      ,[F39]
      ,[F40]

GO

-- dropping null columns
ALTER TABLE [dbo].['Company Expenses$'] DROP COLUMN [F40]
      ,[F41]
      ,[F42]
      ,[F43]
      ,[F44]
      ,[F45]
      ,[F46]
      ,[F47]
      ,[F48]
      ,[F49]
      ,[F50]
      ,[F51]
      ,[F52]
      ,[F53]
      ,[F54]
      ,[F55]
      ,[F56]
      ,[F57]
      ,[F58]
      ,[F59]
      ,[F60]
      ,[F61]
      ,[F62]
      ,[F63]
      ,[F64]
      ,[F65]
      ,[F66]
      ,[F67]
      ,[F68]
      ,[F69]
      ,[F70]
      ,[F71]
      ,[F72]
      ,[F73]
      ,[F74]
      ,[F75]
      ,[F76]
      ,[F77]
      ,[F78]

GO

-- dropping null columns
ALTER TABLE [dbo].['Sales Orders$'] DROP COLUMN [F13]
      ,[F14]

GO

-- dropping null columns
ALTER TABLE [dbo].['Transaction Table$'] DROP COLUMN [F6]

GO

-- cleaning balance sheet data, pivot year columns to a single column
SELECT
	-- in this select statement, get the new pivoted columns, which includes the YEAR and VALUE columns.
  [Balance Sheet Type],
  [Category],
  [Sub Category],
  [Year],
  [Value]
-- save the new query in a physical table
INTO BalanceSheetData
FROM
	-- inside the subquery, get the columns of the original table
  (SELECT 
	[Balance Sheet Type], 
	[Category], 
	[Sub Category], 
	[2014], 
	[2015], 
	[2016], 
	[2017], 
	[2018] 
   FROM [dbo].['Balance Sheet Data$']) AS ogTable
UNPIVOT
	-- the FOR ...... part specifies that a new column 'Year' will be created, which will hold the values of the current column headers 
	-- which are the 2014 - 2018 years. afterwards, the 'Value' column will hold the values of the data under the current column headers. 
  ([Value] FOR [Year] IN ([2014], [2015], [2016], [2017], [2018])) AS UnpivotedData;
GO

-- PIVOT VERSION 
/*
SELECT
  [Balance Sheet Type],
  [Category],
  [Sub Category],
  [2014],  -- Create a column for each year
  [2015],
  [2016],
  [2017],
  [2018]
FROM
  (SELECT 
    [Balance Sheet Type],
    [Category],
    [Sub Category],
    [Year],
    [Value]
   FROM [dbo].['Balance Sheet Data$']) AS SourceTable
PIVOT
  (SUM([Value]) FOR [Year] IN ([2014], [2015], [2016], [2017], [2018])) AS PivotedData;
*/

-- unpivot the cash flow data table similar to balance sheet data
SELECT
	[Cash Flow Type],
	[Cash Flow Category],
	[Cash Flow Sub Category],
	[Year],
	[Value]
INTO CashFlowData
FROM
	(
		SELECT
			*
		FROM
			dbo.['Cash Flow Data$']
	) AS ogTable
UNPIVOT
	([Value] FOR [Year] IN ([2014], [2015], [2016], [2017], [2018])) AS UnpivotedData
GO

-- unpivot the company expenses table
SELECT
	[Expense Items],
	[Expense Category],
	[Expense Month],
	[Values]
INTO CompanyExpenses
FROM
	(
	SELECT
		*
	FROM
		dbo.['Company Expenses$']
	) AS ogTable
UNPIVOT
	([Values] FOR [Expense Month] IN (
	[May-15]
      ,[Jun-15]
      ,[Jul-15]
      ,[Aug-15]
      ,[Sep-15]
      ,[Oct-15]
      ,[Nov-15]
      ,[Dec-15]
      ,[Jan-16]
      ,[Feb-16]
      ,[Mar-16]
      ,[Apr-16]
      ,[May-16]
      ,[Jun-16]
      ,[Jul-16]
      ,[Aug-16]
      ,[Sep-16]
      ,[Oct-16]
      ,[Nov-16]
      ,[Dec-16]
      ,[Jan-17]
      ,[Feb-17]
      ,[Mar-17]
      ,[Apr-17]
      ,[May-17]
      ,[Jun-17]
      ,[Jul-17]
      ,[Aug-17]
      ,[Sep-17]
      ,[Oct-17]
      ,[Nov-17]
      ,[Dec-17]
      ,[Jan-18]
      ,[Feb-18]
      ,[Mar-18]
      ,[Apr-18]
      ,[May-18]
	)) AS UnpivotedData
GO