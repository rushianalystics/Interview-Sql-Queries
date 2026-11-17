1) Write an SQL query to find the employees who earn the second-highest salary in each department.

select emp_name , department_name , salary 
from (
select e.emp_name , d.department_name , e.salary ,
dense_rank()over(partition by d.department_name order by e.salary desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
) A
where rnk = 2;

2) Write an SQL query to find departments where the average salary is greater than the overall company average salary.

select d.department_name , avg(e.salary) as avg_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
having avg(e.salary) > (select avg(salary) from employees);

3) Write an SQL query to find the employees who have the same joining date.

select emp_name , joining_date
from employees
where joining_date in (select joining_date
                      from employees
                      group by joining_date
                      having count(*)> 1);

4) Write an SQL query to find the department-wise total salary and display only the top 2 departments based on total salary.

select d.department_name , sum(e.salary) as total_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by sum(e.salary) desc
limit 2;
