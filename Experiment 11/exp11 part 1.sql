
drop table if exists EmployeeSalaryHistory 
CREATE TABLE EmployeeSalaryHistory (
    rid INT PRIMARY KEY,
    emid INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL,
    s_month DATE NOT NULL,
    salary INT NOT NULL
);

INSERT INTO EmployeeSalaryHistory
(rid, emid, emp_name, s_month, salary)
VALUES
(1, 101, 'Alok', '2026-01-01', 50000),
(2, 101, 'Alok', '2026-02-01', 52000),
(3, 101, 'Alok', '2026-03-01', 55000),

(4, 102, 'Priya', '2026-01-01', 60000),
(5, 102, 'Priya', '2026-02-01', 58000),
(6, 102, 'Priya', '2026-03-01', 62000),

(7, 103, 'Raj', '2026-01-01', 45000),
(8, 103, 'Raj', '2026-02-01', 47000),
(9, 103, 'Raj', '2026-03-01', 49000),

(10, 104, 'Sneha', '2026-01-01', 70000),
(11, 104, 'Sneha', '2026-02-01', 70000),
(12, 104, 'Sneha', '2026-03-01', 72000);


Select E.emid, E.emp_name
FROM (
	select *, LAG(salary,1) OVER(partition by emid ORDER BY s_month) as prev_salary
	FROM EmployeeSalaryHistory
) as E
GROUP BY E.emid, E.emp_name
HAVING COUNT(*) FILTER(
	WHERE salary <= prev_salary
) = 0;


