/*
Create table If Not Exists Employee (Id int, Salary int)
Truncate table Employee
insert into Employee (Id, Salary) values ('1', '100')
insert into Employee (Id, Salary) values ('2', '200')
insert into Employee (Id, Salary) values ('3', '300')


Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

*/

/* some duplicate test data
 insert into Employee (Id, Salary) values ('4', '200')
 insert into Employee (Id, Salary) values ('5', '300')
*/

Select * From Employee Order by Salary Desc;

-- lets rank
Select Salary
      ,Dense_Rank() Over ( Order By Salary Desc) TheRank
From Employee;

-- the second highest
Select es.Salary
From ( Select Salary
             ,Dense_Rank() Over ( Order By Salary Desc) TheRank
       From Employee
     ) es
Where es.TheRank = 2;

/* add in : 
    If there is no second highest salary, 
    then the query should return null.
    Max helps with ties and null
*/
Select 
    Max(Case 
            When es.TheRank = 2 Then es.Salary
            Else Null
        End 
       ) SecondHighestSalary
From ( Select Salary
             ,Dense_Rank() Over ( Order By Salary Desc) TheRank
       From Employee
     ) es
Where es.TheRank = 2;

