/*
Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example:

Logs table:
+----+-----+
| Id | Num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

Result table:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
1 is the only number that appears consecutively for at least three times.
*/

Create table Logs (Id int, Num int)
Truncate table Logs
insert into Logs (Id, Num) values ('1', '1')
insert into Logs (Id, Num) values ('2', '1')
insert into Logs (Id, Num) values ('3', '1')
insert into Logs (Id, Num) values ('4', '2')
insert into Logs (Id, Num) values ('5', '1')
insert into Logs (Id, Num) values ('6', '2')
insert into Logs (Id, Num) values ('7', '2')

Select * from Logs

-- Write an SQL query to find all numbers that appear at least three times consecutively.

/* lots of options:
1. Can self join three times
2. Can use Lag to access the previous two rows
3. Can use Lead to access the next two rows
*/

Select Distinct num as ConsecutiveNums 
From (
    Select num
          ,lead(num, 1) over(order by id) as nextRow1
          ,lead(num, 2) over(order by id) as nextRow2
    From Logs
) t
where num = nextRow1 and num = nextRow2;

/*
Runtime: 906 ms, faster than 99.30% of MS SQL Server online submissions for Consecutive Numbers.
Memory Usage: 0B, less than 100.00% of MS SQL Server online submissions for Consecutive Numbers.
*/