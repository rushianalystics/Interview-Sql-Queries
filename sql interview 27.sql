1) Write an SQL query to find the third-highest distinct salary in the company.

select emp_name , salary 
from (
select e.emp_name , e.salary ,
dense_rank()over(order by e.salary desc) as rnk
from employees e
) A
where rnk = 3;

2) Find employees who joined in the last 3 years

select emp_name , joining_date
from employees
where joining_date >= date_sub(curdate(),interval 3 year );

3) Write an SQL query to count the number of employees hired in each year.

select count(*) as num_of_emp , year(joining_date) as joining_year
from employees
group by year(joining_date);

4) Write an SQL query to find the percentage of employees in each department out of the total employees in the company.

select d.department_name , 
count(e.emp_id) * 100.0 / ( select count(*) from employees) as percentage_ofemp
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;
