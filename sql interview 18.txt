1) Find the department with the highest number of employees, without using LIMIT.

with dept_count as (
select d.department_name , 
count(e.emp_id) as nu_of_emp_count,
dense_rank()over( order by count(e.emp_id) desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
)
select department_name , nu_of_emp_count
from dept_count
where rnk = 1;

2) Find employees whose salary is higher than the salary of the previous employee in the same department, based on joining date.

WITH employee_data AS (
    SELECT
        e.emp_name,
        e.salary,
        d.department_name,
        e.joining_date,
        LAG(e.salary) OVER (
            PARTITION BY e.department_id
            ORDER BY e.joining_date
        ) AS previous_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
)
SELECT emp_name, salary, department_name, previous_salary
FROM employee_data
WHERE salary > previous_salary;

3) Find the department name and total salary of each department. Display only those departments whose total salary is greater than ₹1,00,000.

select d.department_name , sum(e.salary) as total_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name 
having sum(e.salary) > 100000;

4) Find employees who earn more than the average salary of the entire company.

select e.emp_name , e.salary
from employees e
where e.salary > (select avg(e2.salary) from employees e2);

5) Find each department's name and number of employees, including departments that have zero employees.

select d.department_name , count(e.emp_id) as nu_of_emp
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name;



