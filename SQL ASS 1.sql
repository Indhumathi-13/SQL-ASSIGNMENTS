 Create database Employee;
USE Employee;
Create table Departments(
Department_id Int primary key,
Department_name varchar(50) not null unique
);

create table Location(
Location_id INT primary key auto_increment,
Location varchar(50) not null unique
);

create table Employees(
Employee_id INT primary key,
Employee_name Varchar(50) not null,
gender ENUM('M','F'),
Age INT check(age>=18),
Hire_Date DATE default (Current_date),
Designation Varchar(50),
Department_id INT,
Location_id int,
Salary decimal(10,2),
foreign key(Department_id) REFERENCES Departments(Department_id),
foreign key(Location_id) REFERENCES Location(Location_id)
);

INSERT INTO Departments(Department_id, Department_name)
values
(001,'HR'),
(002,'Sales'),
(003,'Finance'),
(004,'Mareketing');

select* from Departments;

INSERT INTO Location(Location_id,Location )
VALUES ( 1, 'Chennai'),
(2,'coimbatore'),
(3,'banglore'),
(4,'trichy'),
(5,'Salem');

select*from Location;

INSERT INTO Employees(Employee_id, Employee_name, gender, Age, Hire_Date, Designation, Department_id, Location_id, Salary)
VALUES(01,'Aandh', 'M', 40, '2012-7-15','Manager', 001, 2, 50000),
(02,'Elakiya', 'F', 35, '2016-5-14', 'Ass Manager', 001, 3, 45000),
(03,'Indhu','F', 28, '2018-2-11', 'Team lead', 002,4,47000),
(04, 'karthik','M', 33, '2016-11-16', 'Hr Excecutive', 003, 2, 33000),
(05, 'Rithvik','M', 25, '2021-04-03', 'Trainee' , 004, 1, 38000); 

select*from Employees;

show tables;

-- 1. Add email
ALTER TABLE Employees
ADD Email VARCHAR(100);

-- 2. Modified datatype
ALTER TABLE Employees
MODIFY designation VARCHAR(100);

-- 3. Drop Age column
ALTER TABLE Employees
DROP COLUMN Age;

-- 4. Rename Hire_date to date_of_joining
ALTER TABLE Employees
RENAME COLUMN Hire_Date TO date_of_joining;

describe Employees;

-- Rename Departments
Rename table Departments TO Department_info;

-- Rename location
rename table location to locations;

-- truncate
TRUNCATE table Employees;
select*from employees;
use employee;
Drop database employee;



