/*
Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

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

-- Problem 177: make into a function
CREATE FUNCTION getNthHighestSalary(N INT) 
RETURNS INT
Deterministic
BEGIN
  RETURN (
      -- # Write your MySQL query statement below.
      Select Max(Case 
                    When es.TheRank = N Then es.Salary
                    Else Null
                End 
                ) NthHighestSalary
From ( Select Salary
             ,Dense_Rank() Over ( Order By Salary Desc) TheRank
       From Employee
     ) es
Where es.TheRank = N
  );
END

Select getNthHighestSalary(2) as Second;
Select getNthHighestSalary(3) as Three;
Select getNthHighestSalary(4) as Four;
Select getNthHighestSalary(1) as One;


