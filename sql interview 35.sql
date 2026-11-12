1) Write an SQL query to find the total salary paid by each department and calculate each department's percentage contribution to the company's total salary expenditure.

SELECT
    d.department_name,
    SUM(e.salary) AS total_salary,
    SUM(e.salary) * 100.0 /
    (SELECT SUM(salary) FROM employees) AS salary_percentage
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name;

2) Write an SQL query to find the employees whose salary is higher than the salary of every employee in the HR department.

SELECT
    e.emp_name,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT MAX(e2.salary)
    FROM employees e2
    JOIN departments d
        ON e2.department_id = d.department_id
    WHERE d.department_name = 'HR'
);

3) Write an SQL query to find employees who are earning less than their respective department's average salary.

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
