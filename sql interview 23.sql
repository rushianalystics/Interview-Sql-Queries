1) Find the most recently hired employee in each department. If multiple employees have the same joining date, return only one employee per department.

select department_name , joining_date , emp_name
from (
select d.department_name , e.joining_date, e.emp_name,
row_number()over(partition by e.department_id order by e.joining_date desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
) A
where rnk = 1;

2) Display each employee's name and their manager's name. If an employee has no manager, display 'No Manager' instead of NULL.

SELECT
    e.emp_name AS employee_name,
    COALESCE(m.emp_name, 'No Manager') AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;

3) Find the top 3 departments by total salary, including ties, without using LIMIT.

WITH dept_salary AS (
    SELECT
        d.department_name,
        SUM(e.salary) AS total_salary,
        DENSE_RANK() OVER (
            ORDER BY SUM(e.salary) DESC
        ) AS rnk
    FROM departments d
    JOIN employees e
        ON e.department_id = d.department_id
    GROUP BY d.department_name
)
SELECT department_name, total_salary
FROM dept_salary
WHERE rnk <= 3
ORDER BY total_salary DESC;
