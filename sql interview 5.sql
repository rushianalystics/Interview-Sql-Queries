1) Write a SQL query to find employees who earn more than the average salary of all employees in the company.

select e.emp_name , e.salary
from employees e
where e.salary > (select avg(e.salary) from employees);

2) Write a SQL query to find the employees who have the same salary.

select emp_name , salary
from employees
where salary in (select salary from employees
		group by salary
                having count(*) > 1);

3) Write a SQL query to find the employees who earn the highest salary in each department.

select emp_name , salary , department_name
from ( select e.emp_name , e.salary , d.department_name,
dense_rank()over(partition by d.department_name order by e.salary desc) rnk
from employees e
right join departments d
on e.department_id = d.department_id
) A
where rnk = 1;

4) Write a SQL query to find the employees who earn the second-highest distinct salary in the company.

select salary , emp_name ,  department_name
from ( select e.emp_name , e.salary , d.department_name,
dense_rank()over( order by e.salary desc) rnk
from employees e
left join departments d
on e.department_id = d.department_id
) A
where rnk = 2;

5) Write a SQL query to find departments where no employees are assigned.

select d.department_name , e.emp_id 
from employees e
right join departments d
on e.department_id = d.department_id
where e.emp_id is null;


