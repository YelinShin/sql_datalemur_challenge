/*
https://datalemur.com/questions/median-search-freq
Google's marketing team is making a Superbowl commercial and needs a simple statistic to put on their TV ad: the median number of searches a person made last year.
However, at Google scale, querying the 2 trillion searches is too costly. Luckily, you have access to the summary table which tells you the number of searches made last year and how many Google users fall into that bucket.
Write a query to report the median of searches made by a user. Round the median to one decimal point.
*/

-- CTE query with expanding the list by generate series function 
with expanded_list
as
(SELECT searches
from (select *, GENERATE_SERIES(1,num_users)
from search_frequency
order by searches) expand)

-- calcualte median which is 50th percentile by percentile_count funciton 
select PERCENTILE_CONT(0.5) within group (order by searches)
from expanded_list
