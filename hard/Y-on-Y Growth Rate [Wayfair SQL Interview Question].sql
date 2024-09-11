/*
https://datalemur.com/questions/yoy-growth-rate
Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.
The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.
*/

--using CTE to calculate each product's yearly spending
with product_yr_spend
as 
(SELECT extract(year from transaction_date) as year, product_id, sum(spend) as spending
FROM user_transactions
group by extract(year from transaction_date), product_id
order by product_id, extract(year from transaction_date))

-- calcualte previous year spending by LAG window function and calculate yoy_rate
select A.*, round(((curr_year_spend-prev_year_spend)/prev_year_spend)*100,2) as yoy_rate
from 
(select year, product_id, spending as curr_year_spend,
lag(spending) over (partition by product_id
order by year asc) as prev_year_spend
from product_yr_spend) A

