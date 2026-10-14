1) Write a SQL query to find the employees who do not have a manager.

select emp_name , manager_id 
from employees
where manager_id is null;

2) Write a SQL query to find the total number of employees in each department, including departments with zero employees.

select d.department_name , count(e.emp_id) as total_nu_emp
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name;

3) Write a SQL query to find the employees whose salary is the second-highest in their department.

select emp_name , salary , department_name
from (select e.emp_name , e.salary , d.department_name,
dense_rank()over(partition by d.department_name order by e.salary desc) as rnk
from employees e
left join departments d
on e.department_id = d.department_id
) A
where rnk = 2;

4) Write a SQL query to find the departments whose total salary is greater than ₹1,00,000.

select d.department_name , sum(e.salary) as total_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name
having sum(e.salary) > 100000;

5) Write a SQL query to find the employees who earn the same salary as at least one other employee.

select emp_name , salary
from employees
where salary in (select salary from employees
		 group by salary
                 having count(*) > 1);
