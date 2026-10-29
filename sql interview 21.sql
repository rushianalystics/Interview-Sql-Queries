1) Write a SQL query to find the department with the highest average salary.

select d.department_name , avg(e.salary) as high_avg_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name
order by avg(e.salary) desc
limit 1;

2) Write a SQL query to find employees whose salary is greater than the average salary of their own department.

select e.emp_name , e.salary 
from employees e
where e.salary > (select avg(e2.salary) from employees e2
                  where e.department_id = e2.department_id);

3) Write a SQL query to display each employee's name along with their manager's name.

select e.emp_name , e.emp_id ,
m.emp_name as manager_name , m.emp_id as manager_id
from employees e
inner join employees m
on e.manager_id = m.emp_id;

4) Write a SQL query to find employees who earn more than their manager.

select e.emp_name , e.salary ,
m.emp_name as manager_name,
m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.emp_id
where e.salary > m.salary;

5) Write a SQL query to display employees who earn less than their manager.

select e.emp_name , e.salary,
m.emp_name as manager_name,
m.salary as manager_salary
from employees e 
join employees m
on e.manager_id = m.emp_id
where e.salary < m.salary;
