create database NEWDB1

use NewDB1

create table students(
Student_id int,
Student_name varchar(20),
Age int,
Gender varchar(20),
Cource varchar(20),
Fees int,
City varchar(20),
);

select *from students;

insert into students(Student_id,Student_name,Age,Gender,Cource,Fees,City)values
(1,'Adith',21,'Male','DA',50000,'calicut'),
(2,'Rahul',25,'Male','BCA',30000,'calicut'),
(3,'Anu','20','Female','BBA',50000,'kannur'),
(4, 'Arjun', 23, 'Male', 'BSc', 55000, 'Kozhikode'),
(5, 'Meera', 21, 'Female', 'DA', 50000, 'Thrissur'),
(6, 'Vishnu', 22, 'Male', 'BCA', 45000, 'Malappuram'),
(7, 'Diya', 20, 'Female', 'BCom', 42000, 'Calicut'),
(8, 'Akhil', 24, 'Male', 'DA', 60000, 'Kochi'),
(9, 'Fathima', 21, 'Female', 'BBA', 40000, 'Kannur'),
(10, 'Nikhil', 23, 'Male', 'BSc', 55000, 'Kollam');

select *from students;

create table Employee(
Employee_id int,Employee_name varchar(20),Department varchar(20),salary int,Age int,City varchar(20),Experience int);


insert into Employee (Employee_id,Employee_name,Department,salary,Age,City,Experience) values

(1, 'Akhil', 'IT', 40000, 28, 'Kochi',3),
(2, 'Rahul', 'HR', 28000, 25, 'Calicut',2),
(3, 'Arjun', 'Finance', 35000, 32, 'Trivandrum',5),
(4, 'Meera', 'IT', 45000, 30, 'Kochi',6),
(5, 'Sneha', 'HR', 22000, 24, 'Calicut',1),
(6, 'Vishnu', 'Finance', 50000, 35, 'Kochi',7),
(7, 'Anjali', 'IT', 32000, 27, 'Trivandrum',3),
(8, 'Nikhil', 'Marketing', 25000, 26, 'Calicut',2),
(9, 'Fathima', 'HR', 40000, 31, 'Kochi',5),
(10, 'Adith', 'IT', 55000, 29, 'Trivandrum',8);

select *from Employee;

--Arithmetic operators

select employee_name,salary,salary+5000 as salary_bonus from Employee;

select employee_name,salary,salary-2000 as salary_deduction from Employee;

select employee_name,salary,salary*1.10 as salary_increment from Employee;

select employee_name,salary,salary*1.15 as salary_increment from Employee;

--comparison operator

select *from Employee;

select *from Employee where salary>30000;

select *from Employee where salary<25000;

select *from Employee where salary=40000;

select *from Employee where Age>=30;

select *from Employee where Age<=25;

select *from Employee  where Experience!=2;

--Logical operators

select *from Employee where salary>30000 and Experience>2;

select *from Employee where Department='IT' and salary >35000;

select *from Employee where City='kochi' or City='Trivandrum';

select *from Employee where Age>25 and salary < 40000;

select *from Employee where Department='HR' or Experience >5;

select *from Employee where City!='Kochi' and salary>25000;

--between,in,not in

select *from Employee where salary between 25000 and 50000;

select *from Employee where Age between 25 and 35;

select *from Employee where Experience between 2 and 5;

select *from Employee where  Department in ('IT','HR','Finance');

select *from Employee where City in ('Kochi','Calicut','Trivandrum');

select *from Employee where Department not in ('HR','Finance');