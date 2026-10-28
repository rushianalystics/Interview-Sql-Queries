1) Find employees who earn more than their managers. Display the employee name, employee salary, manager name, and manager salary.

select e.emp_name , e.salary,
m.emp_name as manager_name,
m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.emp_id
where e.salary > m.salary;

2) Find the department with the highest average salary, without using LIMIT.

with dept_avg as (
select d.department_name , avg(e.salary) as avg_salary,
dense_rank()over(order by avg(e.salary) desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
)
select department_name , avg_salary
from dept_avg
where rnk = 1

3) Find each department's total number of employees earning more than ₹50,000 and total number earning ₹50,000 or less.

select d.department_name,
sum(case when e.salary > 50000 then 1 else 0 end ) as high_salary_count,
sum(case when e.salary <= 50000 then 1 else 0 end ) as low_salary_count
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;

4) Find departments that have no employees assigned to them.

select d.department_name , e.emp_id
from employees e
right join departments d
on e.department_id = d.department_id
where e.emp_id is null;

5) 
