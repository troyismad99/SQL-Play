/*
The Employee table holds all employees. 
Every employee has an Id, a salary, and there is also a column for the department Id.
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

The Department table holds all departments of the company.
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Write a SQL query to find employees who have the highest salary in each of the departments.
For the above tables, your SQL query should return the following rows (order of rows does not matter).
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
*/

-- TSQL
Create table Employee (Id int, Name varchar(255), Salary int, DepartmentId int)
Create table Department (Id int, Name varchar(255))

insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1')

insert into Department (Id, Name) values ('1', 'IT')
insert into Department (Id, Name) values ('2', 'Sales')

Select * From Employee
Select * From Department

/*
Write a SQL query to find employees who have the highest salary in each of the departments. 
*/

Select Department, Employee, Salary
From (
    Select d.Name As 'Department'
          ,e.Name As 'Employee'
          ,e.Salary 
          ,Rank() Over( Partition By e.DepartmentID Order By e.Salary Desc) as theRank
    From Employee e
    Inner Join Department d on e.DepartmentId = d.Id
) er
Where er.theRank = 1;

/*
Runtime: 1539 ms, faster than 25.54% of MS SQL Server online submissions for Department Highest Salary.
Memory Usage: 0B, less than 100.00% of MS SQL Server online submissions for Department Highest Salary.
*/