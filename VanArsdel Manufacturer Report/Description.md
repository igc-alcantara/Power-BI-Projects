# About the Report
This report is a part of our activity for the DataNow SQL and Power BI Masterclass. We were tasked to give our own insights and report design from a dataset that includes products from different fictional manufacturers, and analyze it in the context of VanArsdel being our company.

# About the Data
The dataset consists of eight Excel files. Seven of the Excel files are sales coming from different countries, with each country having its own Excel file. The last Excel file 'bi_dimensions' contains three sheets, each sheet containing the product names, geological locations, and manufacturer names. This acts as the dimension table for the previous Excel files containing the sales for different countries.

# Data Cleaning and Transformation
The data cleaning and transformation were done using Power Query in Power BI. The Excel file containing the dimensions was first loaded, separating each sheet into its own table.
For the first Excel file, 'bi_dimensions', these were the transformations done on the tables:
## Product Table
- Data was loaded from the source file 'bi_dimensions', then extracted the sheet named Products.
- Some initial column types were not matching the data, these were changed accordingly.
- The 'Category' column only has 4 distinct values. Each of these values appears on the first row of the specific category, and the succeeding values for this column return null. The null values were filled to copy the last non-null value. 
- The 'Product' column has a string pattern similar to this: 'Product Name | Segment'. This column was split into two columns with the delimiter '|'. The column types and names for the columns were adjusted to the appropriate types and renamed to 'Product' and 'Segment'. 
- The 'Price' column is a text column that has the following pattern: 'USD 0.00'.  Using space as the delimiter, the values from this column were separated into two other columns, 'MSRP' and 'Currency'. The 'Price' column was dropped afterwards. 

## Geography Table
- Data was loaded from the source file 'bi_dimensions', then extracted the sheet named Geography.
- Since the sheet does not contain an actual table, it was imported as a whole sheet. Because of this, some rows are not part of the dataset.
- The top three rows of the sheet were removed, and the first remaining row was promoted as the header for the table.
- The column types for each column were modified according to their values.

## Manufacturer Table
- Data was loaded from the source file 'bi_dimensions', then extracted the sheet named Manufacturer.
- This sheet also does not contain a table, and furthermore, the columns and rows were flipped. Meaning that the column headers appear on the first column, and the values for those headers appear in subsequent columns.
- The irrelevant rows were removed from the table first, which was part of the Excel sheet.
- The table was then transposed to convert rows into columns and columns into rows. 
- The first row of the table is then promoted as the headers for the table. 
- The column types are modified according to the row values.

For the six out of the seven Excel files that have the sales data, it was imported as a folder in Power Query, then combined and transformed into a single table called 'International Sales'.

The last Excel file was separated from these files because the six files have an explicit description as to which country they originated from. The last sales file does not have any distinction from which country it originated, as it was assumed to be local in the USA.
The remaining file, 'Sales' is then imported as well to Power Query. This contains the sales for USA, which was not explicitly named in the dataset. The transformations done for this table are listed below:
## Sales Table
- The first row of the table was promoted as the header.
- Column types for the initial sales file were modified according to the values.
- The combined table earlier, 'International Sales', is appended to the current 'Sales' table. 
- Since the original 'Sales' table does not have a country column, and it exists in the 'International Sales' table, all the values for the country column of the original 'Sales' table are null. 
- These null values are changed to 'USA', since it is the local country. 
- The columns are then renamed, and the column type is changed appropriately. 
- The 'International Sales' table was then hidden from the data model since it is now appended to the main  'Sales' table. 

# Data Modeling
Here is the data model for the dataset:
![image](https://github.com/user-attachments/assets/dcd72860-f4f6-4cd6-bb72-5dbbde987a4f)

# Report Insights
## Overview Page
![image](https://github.com/user-attachments/assets/9301b5ce-50b6-40da-95d0-419a537f10c3)

**Insights**

As this is the overview page of the report, it only shows the most high-level data for the end user to get some quick insights into the company trends.

The top KPI cards show the Gross Revenue, Unit Total, and Revenue Market Share. These metrics have all seen growth from the previous year.
- Gross Revenue grew to $224.03M, showing a solid +11.72% increase from 2020.
- Total Units Sold improved significantly, reaching 328K units, with a +16.18% growth YoY.
- Revenue Market Share rose to 46.28%, a +3.53 percentage point gain, indicating VanArsdel is capturing more of the industry’s market.

In the variance chart, we can see which segments brought the most revenue for VanArsdel, and from these segments, which had the highest growth compared to the previous year.
- Moderation segment generated the highest revenue at $98.51M, followed closely by Convenience at $93.99M.
- The Extreme segment, although contributing the least in raw revenue, saw the highest YoY growth at +58.2%, signaling a rising opportunity.

For the line chart it displays how VanArsdel performed in the current year in terms of sales compared to the previous year, measured quarterly.
- VanArsdel outpaced its previous year's revenue in every quarter of 2021.
- Q2 2021 was the peak quarter, reaching $62M, which is $6M higher than Q2 2020.
- Q1 2021 had the largest YoY improvement, jumping from $43M to $49M.

## Geo Sales Page
![image](https://github.com/user-attachments/assets/ec45f10f-03df-40ec-b047-ecbce935493d)

**Insights**

This is the geographical page, wherein data regarding where VanArsdel is best performing and least performing is displayed. It follows the 3-30-300 rule, with the most basic KPIs at the top left, more detailed charts following it, and the matrix table for product-level insights in the bottom right.

The KPI Cards display the Gross Revenue and Revenue Market Share for the countries selected in the slicer.
- Total Gross Revenue for December 2021 reached $16.90M, reflecting a +9.00% YoY increase compared to December 2020 for all countries.
- Revenue Market Share climbed to 44.78%, a strong +4.80% gain, indicating VanArsdel is being more competitive in multiple countries.

The bar charts represent the top 5 and bottom 5 most performing states for VanArsdel, respecting the country filter. The states can also be drilled down further to see the ZIP codes per state.
- New South Wales is VanArsdel’s strongest state performer in December, contributing $2.46M in sales, followed by Victoria ($1.93M) and Queensland ($1.29M).
- DC, New Hampshire, and Manitoba were among the lowest-performing states, with DC only generating $12.22K in revenue.

The line chart displays the top 3 competitors for the industry in the selected month and year, and how VanArsdel compares to these competitors.
- VanArsdel is steadily maintaining a lead over other top competitors such as Natura and Aliqui throughout the year.

Lastly, in the Matrix chart, users are able to drill down through a Category > Segment > Product hierarchy, allowing users to pinpoint which products are selling the most or the least per state and ZIP code.

## Segment View Page
![image](https://github.com/user-attachments/assets/c71a977a-06ab-4d8e-813f-f5ea5d49c233)

**Insights**

In the Segment View page it shows the performance of VanArsdel in relation to each segment of the products. It shows that segments that are performing the best and those that are struggling to sell.

For the KPI cards, it only shows the high level of which segment is selling the most, and which is selling the least. This gives the user high-level knowledge immediately as to which segments are causing a problem for the revenue of the company.
- Moderation is VanArsdel’s top-performing segment, contributing 45.73% of total sales in December 2021, indicating a consistent demand from consumers.
- Regular is the least-performing segment, accounting for only 0.10% of sales, indicating a potential mismatch between product offerings and market demand or marketing efforts.

The clustered column chart compares the average revenue of the segment with the average MSRP of the segment. If the average revenue is lower than the average MSRP, then that segment is often being discounted or sold at a lower price than intended. This can mean that there is a price mismatch or there is a lack of demand for the segment.
- The Select segment has a notably higher average revenue than MSRP, suggesting strong potential for premium pricing.
- Moderation and Convenience segments are closely aligned in terms of average revenue and MSRP, showing price consistency but less premium pricing potential.

The scatterplot shows which segments deliver the most revenue in relation to their units sold. The size of the points represents the average MSRP per segment.
- From the scatterplot, it can be seen that the segments that are reasonably priced achieve the highest units sold and revenue.
- The Select segment, which is severely overpriced, returns the fewest units sold and revenue.

The line chart shows which quarters drive the most revenue for VanArsdel, filtered by segment. This line chart can be drilled down further to a month and day-to-day measure.
- Q2 and Q3 2021 had the highest revenue for the selected segment (Moderation), peaking at $26.65M and $26.64M respectively.
- There’s a slight drop in Q4 to $23.48M, suggesting a seasonal dip or a need to revitalize end-of-year campaigns for that segment.
- Overall, 2021 outperformed 2020 across all quarters, signaling year-over-year growth.

## Market Review Page
![image](https://github.com/user-attachments/assets/b17c4de8-2f5f-416a-9020-4c666180a020)

**Insights**

For the last page, it compares the performance of VanArsdel against the top competitors in the industry and the industry as a whole.

At the top, the three KPI cards can be seen for Units Sold Market Share, VanArsdel Revenue compared to the industry average, and the YoY growth compared to the industry average.
- VanArsdel owns 29.56% of the units sold market share, marking a +15.11% YoY increase, showing strong product adoption and consumer demand growth.
- VanArsdel’s total revenue is 409.05% higher than the industry average ($224.03M vs. $44.01M), highlighting outperformance in both volume and pricing.
- The company achieved +9.39% YoY growth, edging out the industry’s average of 10.71%, proving consistent performance and growth resilience.

The line chart displays which manufacturers are at the top of the industry based on their market share throughout the year.
- This chart demonstrates VanArsdel has a stable and superior position in market share throughout the year, with no evident dips compared to key competitors Natura and Aliqui, who remain flat or declining.
- The column chart shows the pricing strategies of the manufacturers in the industry per segment, compared to VanArsdel. This can help in monitoring if the pricing strategy for VanArsdel is competitively priced against other manufacturers.

From the segment comparison chart, VanArsdel's average pricing is highly competitive, second only to Leo in the Moderation segment.
- Competitors like Aliqui, Fama, and Pirum offer lower prices, but the value per unit suggests VanArsdel sustains premium pricing without sacrificing volume.

The Matrix chart allows the user to compare the statistics of VanArsdel to the rest of the industry up to a product level. It enables a detailed analysis to figure out the top-selling products for each company, determine the average product pricing per segment of the companies, and other insights that can potentially develop new strategies against the competition.
