1) Find the second-highest average salary among departments, without using LIMIT.

with dept_avg as (
select d.department_name ,
avg(e.salary) as avg_salary,
dense_rank()over(order by avg(e.salary) desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
)
select department_name , avg_salary
from dept_avg
where rnk = 2;

2) Find each department's employee count and calculate how many employees earn more than ₹60,000.

select d.department_name , count(*) as total_emp,
sum(case when e.salary > 60000 then 1 else 0 end ) as emp_above_60000
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;

3) Find pairs of employees who work in the same department and earn the same salary. Do not display an employee paired with themselves or duplicate pairs.

select e1.emp_name as emp_1,
e2.emp_name as emp_2,
e1.department_id,
e1.salary
from employees e1
join employees e2
on e1.department_id = e2.department_id
and e1.salary = e2.salary
and e1.emp_id < e2.emp_id;

4) Find departments where the number of employees is greater than the average number of employees per department.

with  dept_count AS(
select 
d.department_name , 
d.department_id , 
count(e.emp_id) as num_of_emp
from employees e
right join departments d
on e.department_id = d.department_id
group by d.department_name , d.department_id
)
select department_name , num_of_emp
from dept_count
where num_of_emp > (select avg(num_of_emp) from dept_count);

