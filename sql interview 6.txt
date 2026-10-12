1)Write a SQL query to find employees whose salary is higher than their department's average salary.

select e.emp_name , e.salary 
from employees e
where e.salary > (select avg(e2.salary) from employees e2
                  where e.department_id = e2.department_id );

2) Write a SQL query to find the third-highest distinct salary in the company, along with the employee names.

select emp_name , salary  
from (select emp_name , salary , 
dense_rank()over( order by salary desc) as rnk
from employees 
)A
where rnk = 3;

3) Write a SQL query to find the total salary paid by each department, including departments with zero employees.

select d.department_name , 
	coalesce(sum(e.salary),0) as total_salary 
from employees e
right join departments d
    on e.department_id = d.department_id
group by d.department_name;

4) Write a SQL query to find employees who joined in the last 3 years.

select emp_name , joining_date 
from employees
where joining_date < date_sub(curdate(),interval 3 year)
and joining_date <= curdate();

5) Write a SQL query to find the number of employees hired in each year.

select year(joining_date) as hire_year,
count(*) as total_emp
from employees
group by  year(joining_date)
order by hire_year;



