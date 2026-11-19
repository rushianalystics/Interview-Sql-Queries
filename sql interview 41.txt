1) Write an SQL query to find the number of employees in each department and display the department with the highest employee count.

select d.department_name , count(*) as num_of_emp
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by  count(*) desc
limit 1;

2) Write an SQL query to find employees who earn more than the average salary of employees hired in the same year.

select e.emp_name , e.salary , year(e.joining_date) as join_year
from employees e
where e.salary > (select avg(e2.salary) from employees e2
                   where year(e2.joining_date) =  year(e.joining_date) );

3) Write an SQL query to find the department with the lowest total salary expenditure.

select d.department_name , sum(e.salary) as total_salary
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by sum(e.salary)
limit 1;

4) Write an SQL query to find employees who joined before their managers.

SELECT
    e.emp_name AS employee_name,
    e.joining_date AS employee_joining_date,
    m.emp_name AS manager_name,
    m.joining_date AS manager_joining_date
FROM employees e
JOIN employees m
    ON e.manager_id = m.emp_id
WHERE e.joining_date < m.joining_date;

5) Write an SQL query to find the average salary of employees in each department and rank the departments from highest to lowest average salary.

SELECT
    department_name,
    avg_salary,
    DENSE_RANK() OVER (ORDER BY avg_salary DESC) AS dept_rank
FROM (
    SELECT
        d.department_name,
        AVG(e.salary) AS avg_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    GROUP BY d.department_name
) A;
