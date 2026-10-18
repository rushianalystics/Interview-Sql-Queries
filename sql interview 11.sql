1) Find the department-wise percentage of employees earning more than ₹50,000.

select d.department_name ,
round(100.0 * sum( case when e.salary > 5000 then 1 else 0 end ) / count(emp_id),2) as nu_of_percentage
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;

2) Find each department’s salary contribution as a percentage of the company’s total salary.

SELECT d.department_name,
       ROUND(
           SUM(e.salary) * 100.0 /
           (SELECT SUM(salary) FROM employees),
           2
       ) AS salary_percentage
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name;

3) Find the department with the second-highest total salary, without using LIMIT.

WITH dept_salary AS (
    SELECT d.department_name,
           SUM(e.salary) AS total_salary,
           DENSE_RANK() OVER (ORDER BY SUM(e.salary) DESC) AS rnk
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    GROUP BY d.department_name
)
SELECT department_name, total_salary
FROM dept_salary
WHERE rnk = 2;

4) Find the percentage of total employees in each department who joined after 2022-01-01.

select d.department_name , round(100.0*sum(case when e.joining_date > '2022-01-01' then 1 else 0 end)/ count(e.emp_id),2) as emp_percentage
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;\

5) Find the month-wise number of employees who joined the company. Display the month and total number of employees hired.

SELECT 
    YEAR(e.joining_date) AS joining_year,
    MONTH(e.joining_date) AS joining_month,
    COUNT(*) AS nu_of_emp
FROM
    employees e
GROUP BY MONTH(e.joining_date) , YEAR(e.joining_date)
ORDER BY MONTH(e.joining_date) DESC , YEAR(e.joining_date) DESC;

