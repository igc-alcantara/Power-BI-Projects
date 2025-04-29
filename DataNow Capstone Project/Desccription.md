# About the Report
This report was made as a part of our Capstone Project requirement in the SQL and Power BI Masterclass for DataNow, Inc. Our task was to build a project starting from data cleaning, data modeling, and ending with data visualization.  

# About the Data
The data given to us is a single Excel file, with 11 sheets that consist of a combination of tables and templates for the matrix tables. 

The main fact table is the 'Sales Orders' sheet, which holds the data for the individual sale transactions made by the company. Then there are three dimension tables that support the fact table, which are namely: 'Customers', 'Regions', and 'Products' sheets. These tables hold the detailed information regarding their table names, respectively. 

There are other sheets that contain tables but are not related to the previous sheets in any way. These include the 'Company Expenses', 'Balance Sheet Data', 'Cash Flow Data', and 'Transaction Table' sheets. We were given these sheets to derive our own insights regarding each sheet into a single page. 

Lastly, the remaining sheets are templates that can be used for displaying the matrix tables in Power BI, which are the 'IS Template', 'BS Template', and 'CF Template'. However, in my report, I avoided using these templates as it was much easier to create the matrix table using the categories themselves found in the related tables.

# Data Cleaning and Transformation
The initial data cleaning and transformation were done using T-SQL in the SQL Server Management Studio. The Excel file was first imported into SSMS. After the sheets were loaded as tables, I checked each table for any null values present in the tables, and if any of the columns had the wrong data type.

There were some tables that had null columns, and these columns were dropped accordingly since all rows were null. These null columns were present for the 'Balance Sheet', 'Company Expense', 'Sale Orders', and 'Transaction Table' tables in the database.

Three tables also had years and month-years as columns instead of row values. These tables were unpivoted to display the correct columns instead (Years and Month Year). The tables were 'Balance Sheet Data', 'Cash Flow Data', and 'Company Expenses'. 

The next step was to rename the fact and dimension tables accordingly. The 'Sale Orders' table was renamed to 'FactSalesOrders', and the dimension tables were renamed to 'DimCustomers', 'DimRegions', and 'DimProducts'. 
Following that, all the table schemas were verified to check if they had the right constraints and data types, and primary key and foreign key constraints were also added for the tables that needed them. 

After that, the data was then imported into Power BI using the SQL Server data source with the Import mode option. The next set of transformations is done on Power Query.  

For most tables, excluding the template tables which are not used, the transformations done in Power Query were only the changing of the column names and the data types of the columns. However, there were two tables that required more transformations.

## CashFlowData
- In addition to the renaming and changing the data types of the columns, this table also needed the 'Value' column to be modified.
- There were negative values present in the 'Values'  column. These were fixed by transforming all values to be the absolute value instead. 
- This is done because there were incoming and outgoing categories for the cash flow. If the outgoing cash is to be subtracted from the incoming cash, and the outgoing cash value is negative, then it will result in addition instead of subtraction.

## CompanyExpenses
- This table had the Month-Year column values. The values for this column follow this format: 'May-15', 'Jun-15', etc.
- This is not a format that can be converted to a date column, which is why a new column was added to follow this format instead: 'May 2015', 'Jun 2015', etc.
- The data type of this new column is then changed to date to be able to connect it to a data table, and the original column that had the wrong format was dropped.
- The Date table was created as a calculated table, and different measure tables were also created to organize the measures into different categories.

# Date Modeling
For the data model,  I created a star schema with the fact table as the main table and the dimension tables as the supporting tables. However, there are other tables that are also dependent on the date table, which are not related to the fact table itself. As such, I also created relationships between those tables and the date table, transforming it to a slightly modified star schema. 
![image](https://github.com/user-attachments/assets/731e8049-5339-4ef4-9964-d314f939fea5)

# Report Insights
## Executive Summary
![image](https://github.com/user-attachments/assets/e3df49fe-0abd-41e5-9e12-39de968959d5)
**Insights**

As the overview page of the financial report, this section provides a high-level snapshot of the company’s financial performance to quickly inform stakeholders of key trends.

The top KPI cards highlight Gross Revenue, Net Profit, and Total Orders.
- **Gross Revenue** reached €57M, although it experienced a slight -0.6% decline compared to 2016.
- **Net Profit** totaled €29M, reflecting a -1.6% decrease from the previous year, suggesting some margin pressures.
- **Total Orders** amounted to 25K, with a minimal -0.3% drop versus 2016.

In the cash flow column chart, we can see that despite minor year-over-year declines in revenue and profit, net cash flow consistently improved each year.
- From 2015 to 2018, net cash flow grew steadily, with 2018 achieving the highest net cash inflow of €158K.
- This highlights strengthened cash management practices even amidst slight revenue and profit declines.

The profitability line chart compares net profit trends monthly between the current and previous year.
- October 2017 recorded the highest monthly net profit, outperforming the same period in 2016.
- While monthly profitability varied, the company managed to match or exceed prior year net profit levels in key months, showing resilience and operational improvements.

## Income Statement
![image](https://github.com/user-attachments/assets/0f06f532-24c7-409b-b7d2-a180eab5df57)
**Insights**
This page provides a detailed view of the company’s financial performance trends, with a particular focus on how revenue translates to profitability and expense management.

The top KPI cards summarize the year’s key figures:
- **Gross Revenue** remained steady at €57M, experiencing a slight -0.6% decrease compared to 2016.
- **Total Expenses** amounted to €27M, showing a marginal increase of +0.4% year-over-year.
- **Net Profit** reached €29M, reflecting a -1.6% decline from the prior year.

The waterfall chart illustrates how revenue flows through key expense categories:
- From €57M of revenue, €11M was absorbed by operating expenses and €16M by COGS, resulting in a €29M net profit.
- This flow emphasizes where major costs are impacting profitability and highlights the efficiency of cost management efforts.

In the stacked column chart comparing monthly revenues and expenses:
- Revenue consistently outpaced expenses each month, ensuring positive monthly margins.
- However, there is a visible compression of margins during mid-year months such as May and June.

The matrix table displays a quarterly breakdown of the income statement by type and item:
- Revenue streams are diversified across Distributor, Export, and Wholesale channels, with Wholesale contributing the highest amount.
- COGS remains a significant portion of expenses when compared to the other expenses, such as Employee Investment, Depreciation Expense, Equipment, etc.

Overall, this page shows that while the company remains profitable, slight increases in expenses have placed some pressure on net income, signaling the need for continued focus on cost efficiency moving forward.

## Financial Details
![image](https://github.com/user-attachments/assets/12087ed7-a6c3-40b4-ac95-8b3e992a1560)
**Insights**

This page provides a breakdown of revenue channels and expense contributors, offering a more detailed view into what drives profitability.

The top left chart highlights where most spending occurs:
- **COGS (Cost of Goods Sold)** is the largest expense category at €16M, followed by Other Expenses and Payroll.
- Marketing and Renting Office Space represent the least spending, indicating tighter control over discretionary expenses.

In the channel revenue comparison:
- **Wholesale** remains the top revenue driver at €31M for 2017, though it showed a slight decline of -0.1% compared to the previous year.
- **Distributor** followed with €17M in revenue but experienced a -3.9% decline.
- Meanwhile, **Export** delivered €8M and achieved the highest growth rate at +5.0%, signaling an opportunity for expansion in that segment.

The quarterly contribution chart shows how revenue was distributed throughout the year:
- **Q2** contributed the highest share at 26.5% (€14.97M), followed closely by Q4 at 25.5%.
- **Q1** contributed the least with 23.4%, suggesting a slower start to the fiscal year.

Finally, the revenue trend line chart compares current year performance against prior year benchmarks:
- Revenue peaked in Q2 2017 at €15.0M but experienced a decline in Q3 before partially recovering in Q4.
- Compared to 2016, Q2 remained strong, but Q3 revenue slightly underperformed against the previous year.

This analysis helps pinpoint which revenue channels and expense categories should be prioritized or optimized to sustain profitability.

## Balance Sheet
![image](https://github.com/user-attachments/assets/4a6c8832-ebc3-427e-85b7-711e31ce9a84)
**Insights**

This page provides a snapshot of the company’s financial position by summarizing key elements of the balance sheet: assets, liabilities, and equity.

The top KPI cards display:
- **Total Assets** grew to €36K, a modest +0.04% increase compared to the previous year.
- **Total Liabilities** also rose slightly to €16K, up by +0.07%.
- **Owner’s Equity** improved to €12K, with a +0.03% growth YoY.

The equity trend line visual shows steady equity growth across reporting years:
- Equity remained stable from 2015 to 2017, with slight upward movement each year.

The liabilities composition chart breaks down liabilities into current and long-term obligations:
- Current liabilities have consistently made up the larger share of total liabilities across all four years.
- Long-term liabilities have stayed steady at €4K annually, indicating a stable debt structure.

Finally, the decomposition tree on the bottom right offers a detailed breakdown of balance sheet components:
- **Current Assets** dominate at €18.9K, with cash making up the largest portion (€11.9K).
- **Fixed (Long-Term)** Assets account for €16.6K.
- **Owner’s Equity** and Liabilities balance out the rest of the financial structure, reaffirming a healthy and balanced financial standing.

Together, these views allow stakeholders to quickly assess the strength and composition of the company’s financial health.

## Cash Flow Statement
![image](https://github.com/user-attachments/assets/0ad11899-d496-482e-99c6-a663c3685198)
**Insights**

This page presents a breakdown of how cash is moving in and out of the business, segmented by operating, financing, and investing activities.

The KPI cards give a quick snapshot of net cash flow performance by activity type:
- **Operating Activities** generated a positive net cash flow of €225K, showing a strong +15% growth versus the previous year.
- **Financing Activities** resulted in a net outflow of -€49K, declining -15% YoY.
- **Investing Activities** also showed a negative flow of -€63K, likewise down -15%.

The clustered column chart shows the difference between cash receipts and cash paid for within each activity:
- Operating activities recorded the highest inflows at €1.05M, mainly from customer receipts.
- Outflows were largest in operating activities as well, particularly in inventory purchases and wages.
- Investing and financing activities both saw relatively lower volumes but still had a net negative impact on total cash.

The waterfall chart visually answers the question, "How Do Different Activity Types Contribute to Net Cash Flow?"
- Operating Activities drove the majority of the positive cash flow.
- Other cash movements added a small positive contribution (€23.8K).
- Financing and investing activities brought down the net with outflows of -€48.7K and -€62.9K, respectively.

The matrix on the bottom right breaks this down further:
- Cash flow is detailed per sub-category (e.g., interest, income taxes, inventory purchases), along with YoY variance and growth rates.
- A consistent +15% growth is seen across key inflow and outflow categories like customer receipts and general expenses, highlighting steady operational scaling.

This page allows decision-makers to assess how effectively the company is generating and utilizing cash across core activities.

## Aged Trial Balance
![image](https://github.com/user-attachments/assets/92541718-a036-44b9-ae5b-427a37481495)
**Insights**

This page focuses on outstanding receivables, customer payment behaviors, and aging risks.

The KPI cards immediately provide an overview of the receivables situation:
- **Total Outstanding** Receivables amount to €2M.
- **Total Invoice** Count stands at 407 invoices.

The breakdown by aging buckets shows where most risks are concentrated:
- A significant €1.6M of outstanding receivables fall into the 90+ days bucket, signaling potential collection risks.
- The 31–60, 61–90, and 1–30 day groups each hold much smaller balances between €0.2M and €0.3M.

In the customer breakdown charts:
- **Ascend Ltd** and **Tagfeed Ltd** are the top customers with the highest outstanding invoice amounts, both exceeding €40K.
- **Cogilith Group** and **Thoughtmix Ltd** show the least outstanding balances at just €2K each.

The customer days-left analysis reveals the firms with the most time remaining on their invoices:
- **Aldi Ltd** leads with 190 days left, followed closely by Zoovu Corp and Aibox Company.
- This suggests a portion of the outstanding receivables are not yet overdue but still pose long-term exposure.

The bottom right trend chart tracks how total receivables evolved monthly:
- Total receivables increased sharply through the first half of the year, reaching a plateau around €4.5M by October and maintaining through year-end.
- This consistent high receivables level implies stable billing but possible slowdowns in collection.

This page helps finance teams identify payment delays early, prioritize collections, and monitor customer credit risks more effectively.
