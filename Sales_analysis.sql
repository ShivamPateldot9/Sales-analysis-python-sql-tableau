CREATE TABLE sales (
    invoice_id       VARCHAR(30)   NOT NULL PRIMARY KEY,
    branch           VARCHAR(50)   NOT NULL,
    city             VARCHAR(30)   NOT NULL,
    customer_type    VARCHAR(30)   NOT NULL,
    gender           VARCHAR(10)   NOT NULL,
    product_name     VARCHAR(100)  NOT NULL,
    product_line     VARCHAR(100)  NOT NULL,
    unit_price       NUMERIC(10,2) NOT NULL,
    quantity         INT           NOT NULL,
    vat              NUMERIC(10,4) NOT NULL,
    total            NUMERIC(12,4) NOT NULL,
    sale_date        TIMESTAMP     NOT NULL,
    sale_time        TIME          NOT NULL,
    payment          VARCHAR(15)   NOT NULL,
    cogs             NUMERIC(10,2) NOT NULL,
    gross_margin_pct NUMERIC(11,9),
    gross_income     NUMERIC(12,4),
    rating           NUMERIC(3,1),
    time_of_day      VARCHAR(20),
    day_name         VARCHAR(15),
    month_name       VARCHAR(15),
    product_category VARCHAR(20)
);


--------------------------- DATA CLEANING -------------------------------

-- 1. Check Total records

SELECT count(*) as Total_records 
FROM sales;


-- 2. Check Duplicate Invoice IDs

SELECT invoice_id,
COUNT(*) AS Total
FROM sales
GROUP BY invoice_id
HAVING COUNT(*) > 1


-- 3. Check Blank Values

SELECT *
FROM sales
WHERE TRIM(city)=''
OR TRIM(branch)=''
OR TRIM(customer_type)=''
OR TRIM(product_line)=''
OR TRIM(payment)='';


-- 4. Remove Extra Spaces

UPDATE sales
SET
    city = TRIM(city),
    branch = TRIM(branch),
    customer_type = TRIM(customer_type),
    gender = TRIM(gender),
    product_line = TRIM(product_line),
    payment = TRIM(payment);



-- 5.Validate Quantity

SELECT *
FROM sales
WHERE quantity <= 0;


-- 6. Validate Unit Price

SELECT *
FROM sales
WHERE unit_price <= 0;


-------------------- Exploratory Data Analysis (EDA)----------------------

-- 1.How many distinct cities are present in the dataset?

SELECT COUNT(DISTINCT city )
FROM sales

-- 2.In which city is each branch situated?

SELECT DISTINCT branch, city 
FROM sales 
ORDER BY branch


-- 3. What is the most common payment method?

SELECT payment, Count(payment) As Common_payment_method
FROM sales
Group by payment
Order By Common_payment_method Desc
Limit 1

-- ANS:  Ewallet = 345


-- 4.What is the most selling product line?

SELECT product_line, Count(product_line) As Most_selling_product
FROM sales
Group by product_line
Order By Most_selling_product Desc
Limit 1

-- ANS : Fashion accessories = 178


-- 5.What is the total revenue by month?

SELECT month_name, Round(SUM(Total) :: numeric,2) AS Total_revenue
FROM sales
GROUP BY month_name
ORDER BY Total_revenue DESC

-- ANS : January = 116291.87, March = 109455.51, February = 97219.37


-- 6. Which month recorded the highest Cost of Goods Sold (COGS)?

SELECT month_name , Round(Sum(cogs):: numeric,2) AS Total_cogs
FROM sales
GROUP BY month_name
ORDER BY Total_cogs DESC
LIMIT 1

-- ANS : January = 110754.16 


-- 7.Which product line generated the highest revenue?

SELECT product_line , Round(SUM(total)::numeric,2) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 1

-- ANS : Food and beverages = 56144.84


-- 8.Which city has the highest revenue?

SELECT city, SUM(total) as Total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1

-- ANS : Delhi = 68311



-- 9.Which product line incurred the highest GST?


SELECT product_line, Round(SUM(vat) :: numeric,2) as VAT
FROM sales
GROUP BY product_line
ORDER BY VAT DESC
LIMIT 1

-- ANS : Food and beverages = 2673.56



-- 10. Which performs better, weekends or weekdays, in terms of total revenue and average bill value?

SELECT
    CASE 
	WHEN day_name IN ('Saturday', 'Sunday') THEN 'Weekend'
	ELSE 'Weekday'
	END AS day_type,
    ROUND(SUM(total)::numeric, 2) AS total_revenue,
    ROUND(AVG(total)::numeric, 2) AS avg_bill
FROM sales
GROUP BY day_type
ORDER BY total_revenue DESC;

-- ANS: Weekday = total_revenue - 222388.05, avg_bill - 316.34
--      Weekend = total_revenue - 100578.70, avg_bill - 338.65














