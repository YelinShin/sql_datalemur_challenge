/*
https://datalemur.com/questions/sql-third-transaction
Assume you are given the table below on Uber transactions made by users. 
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.
*/

-- use CTE to create sorted transactions by user id with ranking
with trans_sort
AS
(SELECT user_id, spend,transaction_date,
rank() over (
partition by user_id
order by transaction_date) as trans_seq
from transactions)

-- select only 3rd transaction by filter rank=trans_seq=3
SELECT user_id, spend, transaction_date FROM trans_sort where trans_seq=3;
