1) Write an SQL query to find the highest-paid employee in each department using a window function.

select emp_name , salary , department_name 
from (select e.emp_name , d.department_name , e.salary,
dense_rank()over(partition by d.department_name order by e.salary desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
) A
where rnk = 1;

2) Write an SQL query to find employees who joined before their respective managers.

SELECT
    e.emp_name AS employee_name,
    e.joining_date AS employee_joining_date,
    m.emp_name AS manager_name,
    m.joining_date AS manager_joining_date
FROM employees e
JOIN employees m
    ON e.manager_id = m.emp_id
WHERE e.joining_date < m.joining_date;

3) Write an SQL query to find the department with the maximum number of employees.

select d.department_name , count(e.emp_id) as number_of_emp
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by count(e.emp_id) desc
limit 1;

4) Write an SQL query to find employees whose salary is in the top 10% of salaries in the company.

SELECT emp_name, salary
FROM (
    SELECT
        emp_name,
        salary,
        PERCENT_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_percentage
    FROM employees
) A
WHERE salary_percentage <= 0.10;

