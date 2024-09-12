/*
https://datalemur.com/questions/user-retention
Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

Hint:
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.
*/

-- CTE to find distinct user id(s) that is active user using exists function -> faster
with get_actv_uer
as
(SELECT distinct curr_month.user_id, extract(month from curr_month.event_date) as month
from user_actions as curr_month
where exists 
  (select last_month.user_id
  from user_actions as last_month
  where last_month.user_id = curr_month.user_id 
    and extract(month from last_month.event_date) = extract(month from curr_month.event_date - INTERVAL '1 month'))
  
  and date_trunc('month',curr_month.event_date) = to_date('07-2022','mm-yyyy'))

-- find activer user count based on the CTE result
select month, count(*) as monthly_active_users
from get_actv_uer
group by month

