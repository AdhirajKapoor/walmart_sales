CREATE DATABASE IF NOT EXISTS salesDataWalmart;
drop table sales;
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
     gender varchar(10) not null,
    product_line VARCHAR (100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct float (12,9),
    gross_income decimal (12,4) not null,
    rating float(2,1)
    );

select* from sales;


-- -------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------Feature Engineering---------------------------------------------------------
SELECT
      time,
(CASE 
     WHEN 'time' between "00:00:00" and  "12:00:00" then "Morning"
     WHEN 'time' between "12:01:00" and  "16:00:00" then "Afternoon"
     ELSE "Evening" END
     ) AS time_of_date
                      from sales;
 
ALTER table sales ADD COLUMN time_of_date VARCHAR (20);
UPDATE sales
SET time_of_date = (
CASE 
     WHEN `time` between "00:00:00" and  "12:00:00" then "Morning"
     WHEN `time` between "12:01:00" and  "16:00:00" then "Afternoon"
     ELSE "Evening" END
);
ALTER table sales RENAME COLUMN time_of_date to time_of_day;

-- ----------------------DAY NAME-----------------------------------------------------------------------------
SELECT 
      date, dayname(date) as day_name FROM sales;
      ALTER table sales ADD COLUMN day_name varchar(10);
      UPDATE sales 
                   set day_name= DAYNAME (date);

-- ------------MONTH NAME------------------------------------------------------

SELECT date, monthname(date) FROM sales;
ALTER table sales ADD COLUMN month_name varchar(10);
UPDATE sales set month_name= MONTHNAME (date);

-- --------------GENERIC QUESTIONS------------------------------------

-- How many unique cities does the data have?
SELECT 
      distinct city FROM sales;
      
-- In which city is each branch?
SELECT 
      distinct city, branch FROM sales;

-- -----------------------------PRODUCT BASED QUESTIONS-------------------------------------------------

-- How many unique products does a data have? 
SELECT 
	  count(distinct product_line) from sales;

-- what is the most ocmmon payment method?
SELECT 
    payment_method,
	count(payment_method) as count from sales
    GROUP BY payment_method
    ORDER BY count DESC;
    
-- what is the most selling product?
SELECT 
      product_line,
	count(product_line) as count from sales
    GROUP BY product_line
    ORDER BY count DESC;

-- what is the total revenue by month?
SELECT 
      month_name as MONTH,
      SUM(total) AS total_revenue
      FROM sales
      GROUP by month_name 
      ORDER by total_revenue;

-- what month had the larget COGS?
SELECT 
      month_name AS month,
      SUM(cogs) AS cogs
      FROM sales
      GROUP by month_name
      ORDER by cogs DESC;
      
-- what product line has the larget revenue?
SELECT
      product_line,
      SUM(total) AS total_revenue
      FROM sales
      GROUP by product_line
      ORDER by total_revenue desc;
      
-- what is the city with largest revenue?
SELECT
      branch, city,
      SUM(total) AS total_revenue 
      FROM sales
      GROUP by city, branch
      ORDER by total_revenue desc;
      
-- what product line has largest VAT?
SELECT 
      product_line,
      AVG(VAT) AS Avg_tax
      FROM sales
      GROUP by product_line
      ORDER by Avg_tax desc;
      
-- which branch sold more proucts than average product sold?
SELECT
      branch,
      SUM(quantity) AS qty
      FROM sales
      GROUP by branch
      HAVING sum(quantity) > (SELECT AVG(quantity));
      
-- What is the average rating of each product?
SELECT 
      AVG(rating) as Avg_rating,
      product_line
      FROM sales
      GROUP by product_line
      ORDER by avg_rating desc;
      
-- ------------------------------------SALES------------------------------------------------------------
-- What is the number of sales made in each time of the day per weekday?
SELECT 
      time_of_day,
      COUNT(*) as total_sales
      FROM sales
      WHERE day_name = "SUNDAY"
      GROUP by time_of_day
      ORDER by total_sales desc;
      
-- Which customer type brings in the most revenue?
SELECT
      customer_type,
      SUM(total) as total_rev
      FROM sales
      GROUP by customer_type
      ORDER by total_rev;
      
-- which city has the largest VAT?
SELECT 
      city,
      ROUND (AVG(VAT),2) as VAT
      FROM sales
      GROUP by city
      ORDER by VAT desc;
      
-- ---------------------------------------CUSTOMERS--------------------------------------------
-- How many unique customer types does the data have?
SELECT 
      DISTINCT customer_type
      FROM sales;

-- What is the gender distribuition per branch?
SELECT
	gender,
    COUNT(*) as gender_count
    FROM sales
    WHERE branch = "B"
    GROUP by gender
    ORDER by gender_count desc;
    
-- which time of the day customers give the most ratrings?
SELECT
      time_of_day, ROUND (AVG(rating),2) as avg_rating
      FROM sales
      GROUP by time_of_day
      ORDER by avg_rating desc;
      


      

     
     
     
     


      
      
      
SELECT* from sales





