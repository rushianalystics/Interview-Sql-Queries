1) Find employees whose salary is higher than the salary of every employee in the HR department.

SELECT e.emp_name, e.salary, d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > ALL (
    SELECT e2.salary
    FROM employees e2
    JOIN departments d2
        ON e2.department_id = d2.department_id
    WHERE d2.department_name = 'HR'
);

2) Find employees who have the same salary as at least one other employee, and display their names and salaries.

select emp_name , salary 
from employees
where salary in (
select salary from employees
group by salary 
having count(*) > 1
order by salary desc);

3) Find the third-highest salary in each department, including employees who earn that salary.

select emp_name , salary , department_name
from (
select e.emp_name , e.salary , d.department_name,
dense_rank()over(partition by d.department_name order by e.salary desc ) as rnk
from employees e
join departments d
on e.department_id = d.department_id
) A
where rnk = 3;

4) Find employees who earn more than the employee immediately hired before them.

with rushi as (
select emp_name , salary , joining_date,
lag(salary) over(order by joining_date) as previous_salary
from employees
)
select emp_name , salary , joining_date , previous_salary
from rushi
where salary > previous_salary;

5) Find employees whose salary is greater than the average salary of their department, and display the department name too.

select e.emp_name , e.salary , d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where salary > (select avg(e2.salary) from employees e2
                where e2.department_id = e.department_id);


