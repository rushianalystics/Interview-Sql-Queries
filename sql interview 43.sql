1) Write an SQL query to find employees whose salary is higher than the salary of every employee in the HR department.

select e1.emp_name , e1.salary
from employees e1
where e1.salary > (select max(e2.salary) from employees e2
                   JOIN departments d
                   on e2.department_id = d.department_id
                  where d.department_name = 'HR');

2) Write an SQL query to find employees who earn less than their department's average salary.

SELECT
    e.emp_name,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary < (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

3) Write an SQL query to find the total number of employees and average salary for each department, including departments with zero employees.

select d.department_name , 
count(e.emp_id) as number_of_emp,
avg(e.salary) as avg_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name;
