CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC(10,2),
    dept_id INT REFERENCES department(dept_id)
);

INSERT INTO department VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'HR');

INSERT INTO employee VALUES
(101, 'Aman', 90000, 1),
(102, 'Neha', 70000, 1),
(103, 'Raj', 50000, 1),
(104, 'Priya', 80000, 2),
(105, 'Karan', 60000, 2),
(106, 'Riya', 40000, 2),
(107, 'Mohit', 75000, 3),
(108, 'Simran', 55000, 3);

select 
  temp.dept_name as department,
  em.emp_name as employee,
  round(em.salary,0) as salary
from employee em
join (
  select 
    d.dept_id,
    d.dept_name,
    Avg(e.salary) as average_salary
  from employee e 
  join department d 
  on e.dept_id = d.dept_id
  group by d.dept_id,d.dept_name
  having count(*) > 2
) temp 
on em.dept_id = temp.dept_id
where em.salary>temp.average_salary