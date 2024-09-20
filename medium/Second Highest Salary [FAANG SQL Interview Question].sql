/*
https://datalemur.com/questions/sql-second-highest-salary

Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.
It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.
*/

select salary
from (SELECT salary,rank() over (order by salary desc) as salary_rank
FROM employee) A
where salary_rank=2;
