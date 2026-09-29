# Sales Analysis Dashboard (SQL + Python + Tableau)

This is an end-to-end data analysis project on a Walmart sales dataset. I loaded the data with Python, did the cleaning and analysis in PostgreSQL, and built a dashboard in Tableau to bring it all together.

## About the Data

- 1,000 transactions from 5 cities (Bangalore, Delhi, Hyderabad, Mumbai, Pune), 15 branches in total (3 per city)
- Covers January to March 2019
- 22 columns: invoice details, product info, pricing, tax, payment method, rating, plus a few fields that were already derived in the raw data (`time_of_day`, `day_name`, `month_name`, `product_category`)

## Tools

- **Python** (pandas, SQLAlchemy) — reading the CSV and pushing it into PostgreSQL
- **PostgreSQL** (pgAdmin) — table setup, cleaning, and all the SQL analysis
- **Tableau** — the dashboard

## How I Went About It

1. Loaded the CSV in Python and ran a quick first-look EDA to understand what I was working with
2. Created the `sales` table in PostgreSQL and loaded the dataset using Python and SQLAlchemy
3. Did cleaning and exploratory analysis in SQL
4. Built a dashboard in Tableau

## Step 1: Python EDA (`Sales_Analysis.ipynb`)

Before performing SQL analysis, I used Pandas to inspect the dataset structure and perform basic exploratory data analysis.

- `df.shape` — confirmed 1,000 rows and 22 columns
- `df.info()` — checked data types column by column
- `df.describe()` — reviewed numeric columns such as `unit_price`, `quantity`, `total`, and `rating`
- `df.isnull().sum()` — checked for missing values
- `df.duplicated().sum()` — checked for duplicate rows
- `df.head()` / `df.columns` — performed an initial inspection of the dataset structure

This initial EDA was used to understand the dataset structure, data types, completeness, and potential data-quality issues before loading the data into PostgreSQL.

## Step 2: Data Cleaning (SQL)

- Checked total record count — 1,000 rows, no duplicate `invoice_id`
- Checked for NULLs and blank strings across the key columns
- Trimmed extra spaces from text columns (`city`, `branch`, `customer_type`, `gender`, `product_line`, `payment`)
- Made sure `quantity` and `unit_price` had no zero or negative values

## Step 3: EDA (SQL)

**Q: Weekday vs weekend — revenue and average bill?**
A: Weekday ₹222,388.05 (avg ₹316.34) · Weekend ₹100,578.70 (avg ₹338.65)
Insight: Weekdays win on total revenue simply because there are more of them, but the average bill is ~7% higher on weekends. This is my own question, added on top of the standard set.

**Q: What is the total revenue by month?**
A: Jan ₹116,291.87, Mar ₹109,455.51, Feb ₹97,219.37
Insight: January is the strongest month (36% of revenue); February is lowest, partly just because it has fewer days.

**Q: Which city has the highest revenue?**
A: Delhi — ₹68,311.51
Insight: Hyderabad is lowest, about 11% behind Delhi.

**Q: Which product line generated the highest revenue?**
A: Food and beverages — ₹56,144.84
Insight: Highest revenue line even though it's not the one with the most orders.

**Q: What is the most common payment method?**
A: Ewallet — 345 orders (34.5%)
Insight: Ewallet and Cash are almost tied (34.5% vs 34.4%), so both need to be well supported.

**Q: Which product line incurred the highest GST?**
A: Food and beverages — ₹2,673.56
Insight: Same ranking as revenue, since VAT is just a fixed % of the sale.

**Q: Which month has the highest COGS?**
A: January — ₹110,754.16
Insight: Moves in step with revenue, so the higher sales in January didn't come from lower costs.

**Q: What is the most selling product line?**
A: Fashion accessories — 178 orders (17.8%)
Insight: Demand is fairly even across all 6 product lines.

**Q: Which city is each branch located in?**
A: 15 branches, 3 per city
Insight: Spread evenly across all 5 cities.

**Q: How many distinct cities are in the dataset?**
A: 5
Insight: Bangalore, Delhi, Hyderabad, Mumbai, Pune.

All 10 questions with full queries and comments are available in `Sales_Analysis.sql`.

## Dashboard

Built in Tableau:
- KPI cards — Total Sales, Profit, Orders, Quantity Sold
- Monthly sales trend
- Top performing branches
- Day-wise sales split
- Top 5 best-selling products

*(dashboard screenshot / Tableau Public link goes here)*

## Key Business Insights

- Delhi generated the highest city-wise revenue, while Hyderabad generated the lowest.
- Weekend average bill was higher than weekday average bill (₹338.65 vs ₹316.34).
- Food and beverages generated the highest revenue among product lines.
- Ewallet and Cash were the two most commonly used payment methods, with nearly equal usage.

## Limitations

- Data only covers Jan–Mar 2019, so I can't say much about seasonality or year-over-year trends
- `gross_margin_pct` is fixed at ~4.76% for basically every row, so profit-margin comparisons across branches or products don't really tell you anything in this dataset
- 1,000 rows is a small sample compared to real retail volumes

## Files

- `Sales_analysis.sql` — table creation, cleaning, and EDA queries with answers
- `Sales_Analysis.ipynb` — Python notebook: CSV load, first-look EDA, and loading the data into PostgreSQL
- Tableau dashboard file / link
