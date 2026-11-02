1) find lower and higher salary in each departments.

select d.department_name , 
max(e.salary) as high_salary,
min(e.salary) as low_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;

2) find number of emp in each department but show show department with more than 2 emp.

select d.department_name , count(*) as total_emp
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
having  count(*) > 2;

3) Write an SQL query to find the average salary of each department and display only those departments whose average salary is greater than ₹50,000.

select d.department_name , avg(e.salary) as avg_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name
having  avg(e.salary) > 50000;

4) Write an SQL query to find employees whose salary is greater than the average salary of the entire company.

select emp_name , salary
from employees 
where salary > (select avg(salary) from employees );

5) Write an SQL query to find the second-highest salary in each department.

select department_name , salary 
from (select d.department_name , e.salary,
dense_rank()over(partition by d.department_name order by e.salary desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
)A
where rnk = 2;  
