1) Write an SQL query to find the employees who joined most recently in each department.

select emp_name , department_name , joining_date
from (
select e.emp_name , d.department_name , e.joining_date,
dense_rank()over(partition by d.department_name order by e.joining_date desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
) A
where rnk = 1;

2) Write an SQL query to find the top 3 departments based on total salary expenditure.

select d.department_name , sum(e.salary) as total_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by sum(e.salary) desc
limit 3;

3) Write an SQL query to find departments that have no employees.

select d.department_name 
from departments d
left join employees e
on d.department_id = e.department_id
where e.emp_id is null
group by d.department_name;

4) Write an SQL query to find the department-wise total number of employees and average salary, including departments with zero employees.

select d.department_name , count(e.emp_id) as emp_count , avg(e.salary) as avg_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name;

5) Write an SQL query to find employees who earn more than the average salary of their department and display their department name.

select e.emp_name , d.department_name , e.salary 
from employees e
join departments d
on e.department_id = d.department_id
having e.salary > (select avg(e2.salary) from employees e2
                   where e.department_id = e2.department_id);
