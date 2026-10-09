1) Write a SQL query to find the employee with the highest salary in the company.

select e.emp_name , e.salary 
from employees e
left join departments d
on e.department_id = d.department_id
order by e.salary desc
limit 1;

2) Write a SQL query to find employees who joined the company in the year 2023.

select e.emp_name , e.salary , e.joining_date
from employees e
left join departments d
on e.department_id = d.department_id
where joining_date between "2023-1-1" and  "2023-12-31";

3) Write a SQL query to find the total number of employees in each department and display only departments with more than 2 employees.

select d.department_name , count(e.emp_id) as total_nu_emp
from employees e
inner join departments d
on e.department_id = d.department_id
group by d.department_name
having count(e.emp_id) > 2;

4) Write a SQL query to find duplicate salaries in the employees table.

select salary , count(salary) as count_same_salary
from employees
group by salary
having count(salary) > 1;

5) Write a SQL query to find the employees who earn the third-highest distinct salary in the company.

select distinct(salary) , emp_name 
from (select emp_name , salary,
dense_rank()over(order by salary desc) as rnk
from employees
)A
where rnk = 3;
