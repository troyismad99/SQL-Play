/*
The Trips table holds all taxi trips. 
Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the Users table. 

Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).

+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+

The Users table holds all users. 
Each user has an unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).
+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+

Write a SQL query to find the cancellation rate of requests made by 
unbanned users (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013. 
The cancellation rate is computed by dividing the number of canceled (by client or driver) 
requests made by unbanned users by the total number of requests made by unbanned users.


For the above tables, your SQL query should return the following rows with the 
cancellation rate being rounded to two decimal places.
+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+

Create table If Not Exists Trips (Id int, Client_Id int, Driver_Id int, City_Id int, Status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'), Request_at varchar(50))
Create table If Not Exists Users (Users_Id int, Banned varchar(50), Role ENUM('client', 'driver', 'partner'))
Truncate table Trips
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')
Truncate table Users
insert into Users (Users_Id, Banned, Role) values ('1', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('2', 'Yes', 'client')
insert into Users (Users_Id, Banned, Role) values ('3', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('4', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('10', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('11', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('12', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('13', 'No', 'driver')


insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-05');
*/

Select * from Trips;
Select * from Users;

-- trips in the date range
Select * 
From Trips t
Where t.Request_at between '2013-10-01' and '2013-10-03';

-- unbanned users
Select * 
From Trips t
Inner Join Users c on t.Client_Id = c.Users_Id
Inner Join Users d on t.Driver_Id = d.Users_Id
Where t.Request_at between '2013-10-01' and '2013-10-03'
  And c.Banned = 'No'
  And d.Banned = 'No';


-- calulate
Select t.Request_at 'Day',
       Round(
            Sum ( Case t.Status 
                        When 'cancelled_by_driver' Then 1
                        When 'cancelled_by_client' Then 1
                        Else 0
                    End
                )
            / Count(*)
            , 2) 'Cancellation Rate'
From Trips t
Inner Join Users c on t.Client_Id = c.Users_Id
Inner Join Users d on t.Driver_Id = d.Users_Id
Where t.Request_at between '2013-10-01' and '2013-10-03'
  And c.Banned = 'No'
  And d.Banned = 'No'
Group By t.Request_at;

/*
Runtime: 369 ms, faster than 42.12% of MySQL online submissions for Trips and Users.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Trips and Users.
*/