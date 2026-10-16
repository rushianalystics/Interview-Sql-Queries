1) Write a SQL query to display each employee's name and their manager's name, including employees who do not have a manager.

select e.emp_name , m.emp_name as manager_name 
from employees e
left join employees m
on e.manager_id = m.emp_id;

2) Write a SQL query to find employees who work in the same department as their manager.

select e.emp_name , m.emp_name as manager_name , e.department_id
from employees e
join employees m
on e.manager_id = m.emp_id
where e.department_id = m.department_id;

3) Write a SQL query to display each employee's name and their manager's name.

select e.emp_name as emp_name,
m.emp_name as manager_name
from employees e
join employees m
on e.manager_id = m.emp_id;

4) Find employees whose salary is higher than the average salary of all employees in the same department, but only show employees from departments located in Pune.

select e.emp_name , e.salary , d.department_name , d.location
from employees e
left join departments d
on e.department_id = d.department_id
where d.location = "pune" and 
e.salary > (select avg(e2.salary) from employees e2
                  where e2.department_id = e.department_id)

5) Find departments where the number of employees earning more than ₹50,000 is at least 2.

select d.department_name , count(e.emp_id) as nu_of_emp 
from employees e
right join departments d
on e.department_id = d.department_id
where e.salary > 50000
group by d.department_name
having  count(e.emp_id) > 2;
