1) Write a SQL query to find the employees who are not assigned to any department.

select e.emp_name , d.department_id
from employees e
left join departments d 
on e.department_id = d.department_id
where d.department_id is null;

2) Write a SQL query to find the department with the highest total salary.

select d.department_name , sum(e.salary) as high_total_salary
from employees e
right join departments d 
on e.department_id = d.department_id
group by d.department_name
order by max(e.salary) desc
limit 1;

3) Write a SQL query to find the second-highest salary in each department.

select emp_name , salary , department_name
from (
select e.emp_name , e.salary , d.department_name,
dense_rank()over(partition by d.department_name order by e.salary desc ) as rnk
from employees e
right join departments d
on e.department_id = d.department_id
) A 
where rnk = 2;

4) Write a SQL query to find departments where the average salary is greater than 50,000.

select d.department_name , avg(salary) as avg_salary 
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name
having avg(salary) > 50000;

5) Write a SQL query to find the top 2 highest-paid employees in each department.

select emp_name , salary , department_name
from (
select e.emp_name , e.salary , d.department_name,
dense_rank()over(partition by d.department_name order by e.salary desc) as rnk
from employees e
inner join departments d
on e.department_id = d.department_id
) A
where rnk <= 2;
