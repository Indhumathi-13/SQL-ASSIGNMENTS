-- Create the database
CREATE DATABASE employee;

-- Select the database
USE employee;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL,
    designation VARCHAR(50),
    hire_date DATE DEFAULT ( CURRENT_DATE),
    department_id INT,
    department VARCHAR(100),
    location VARCHAR(100),
    location_id INT,
     CONSTRAINT chk_gender
        CHECK (gender IN ('M', 'F')),

    CONSTRAINT chk_age
        CHECK (age >= 18),

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),

    CONSTRAINT fk_employee_location
        FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
);

ALTER TABLE Employees
ADD COLUMN email VARCHAR(100);
ALTER TABLE Employees
ADD COLUMN Salary Decimal(10,2);

ALTER TABLE Employees
MODIFY COLUMN designation VARCHAR(100);
RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;
INSERT INTO Departments_info(Department_id, Department_name)
values
(001,'HR'),
(002,'Sales'),
(003,'Finance'),
(004,'Mareketing'),
(005, 'Management'),
(006, 'Analysis');
select*from departments_info;

INSERT INTO Locations(Location_id,Location_name )
VALUES ( 1, 'Chennai'),
(2,'coimbatore'),
(3,'banglore'),
(4,'trichy'),
(5,'Salem'),
(6, 'Erode');
select*from Locations;


INSERT INTO Employees(Employee_id, Employee_name, gender, Age, Hire_Date, Designation, Department_id,department, location, Location_id, Salary)
VALUES(01,'Aandh', 'M', 40, '2012-7-15','Manager', 001,'HR', 'Coimbatore', 2, 50000.00),
(02,'Elakiya', 'F', 35, '2016-5-14', 'Analyst', 006,'Analysis','Banglore',3, 45000.00),
(03,'Indhu','F', 28, '2018-2-11', 'Analyst', 006,'Analysis', 'Trichy',4,47000.00),
(04, 'Banu','F', 32, '2015-3-10', ' ', 004,'Marketing','Erode', 6, 50000.00),
(05, 'karthik','M', 33, '2016-11-16', 'Finance Excecutive', 003,'Finance','Sale',5, 33000.00),
(06, 'Rithvik','M', 25, '2021-04-03', '' , 004,'Marketing','Chennai',1, 38000.00); 
select*from Employees;

-- DISTINCT COMMANDS
SELECT DISTINCT salary
FROM Employees

-- ALIAS COMMAND
SELECT age AS Employee_Age,
       salary AS Employee_Salary
FROM Employees;

-- WHERE CLAUSES AND OPERATION
SELECT *
FROM Employees
WHERE salary<= 50000
  AND hire_date < '2016-01-01';
  SELECT *
FROM Employees
WHERE designation = ' ';
update employees
set designation='Data scientist'
where Employee_id = 4;


-- ORDER BY COMMAND
SELECT *
FROM Employees
ORDER BY department_id ASC,
         salary DESC;
         
-- LIMIT COMMAND
SELECT *
FROM Employees
WHERE hire_date >= '2018-01-01'
  AND hire_date < '2019-01-01'
ORDER BY hire_date ASC
LIMIT 5;

-- AGG FUNCTION COMMAND LIKE SUM, MIN, MAX, AVG
SELECT SUM(salary) AS Total_Salary
FROM Employees
WHERE department = 'Finance';

SELECT MIN(age) AS Minimum_Age
FROM Employees;

SELECT location, MAX(salary) AS Maximum_Salary
FROM Employees

GROUP BY location;
SELECT designation,
AVG(salary) AS Average_Salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

SELECT department,
       COUNT(*) AS Employee_Count
FROM Employees

-- HAVING 

GROUP BY department
HAVING COUNT(*) < 3;

SELECT location,
       AVG(age) AS Average_Age
FROM Employees
WHERE gender = 'F' GROUP BY location
HAVING AVG(age) < 30;

-- JOINS
SELECT employees.employee_name,
       employees.designation,
       departments_info.department_name
FROM Employees 
INNER JOIN Departments_info 
    ON employees.department_id = departments_info.department_id;
    
SELECT departments_info.department_name,
       COUNT(employees.employee_id) AS Total_Employees
FROM Departments_info
LEFT JOIN Employees 
    ON Departments_info.department_id = Employees .department_id
GROUP BY Departments_info.department_id, Departments_info.department_name; 

SELECT locations.location_name,
       employees.employee_name
FROM Employees 
RIGHT JOIN Locations 
    ON employees.location_id = locations.location_id;
    
    