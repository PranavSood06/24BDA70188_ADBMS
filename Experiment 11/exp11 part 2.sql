DROP TABLE if exists Employee, Department;

CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
INSERT INTO Department (id, name)
VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'HR');

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    departmentId INT,
    FOREIGN KEY (departmentId)
        REFERENCES Department(id)
);

INSERT INTO Employee
(id, name, salary, departmentId)
VALUES
(1, 'Max', 90000, 1),
(2, 'Jim', 85000, 1),
(3, 'John', 85000, 1),
(4, 'Alex', 75000, 1),
(5, 'Sam', 70000, 1),

(6, 'Henry', 80000, 2),
(7, 'Susan', 75000, 2),
(8, 'David', 70000, 2),
(9, 'Robert', 65000, 2),

(10, 'Tina', 60000, 3),
(11, 'Rita', 55000, 3),
(12, 'Manoj', 50000, 3);

SELECT D.name AS Department,
       E.name AS Employee,
       E.salary
FROM (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY departmentId
               ORDER BY salary DESC
           ) AS rnk
    FROM Employee
) E
JOIN Department D
ON E.departmentId = D.id
WHERE rnk <= 3;