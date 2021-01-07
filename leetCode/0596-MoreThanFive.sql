/*
There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:
+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+

Should output:
+---------+
| class   |
+---------+
| Math    |
+---------+
 
Note:
The students should not be counted duplicate in each course.
*/
/*
Create table If Not Exists courses (student varchar(255), class varchar(255));
Truncate table courses;
insert into courses (student, class) values ('A', 'Math');
insert into courses (student, class) values ('B', 'English');
insert into courses (student, class) values ('C', 'Math');
insert into courses (student, class) values ('D', 'Biology');
insert into courses (student, class) values ('E', 'Math');
insert into courses (student, class) values ('F', 'Computer');
insert into courses (student, class) values ('G', 'Math');
insert into courses (student, class) values ('H', 'Math');
insert into courses (student, class) values ('I', 'Math');

insert into courses (student, class) values ('T', 'History');
insert into courses (student, class) values ('T', 'History');
insert into courses (student, class) values ('T', 'History');
insert into courses (student, class) values ('T', 'History');
insert into courses (student, class) values ('T', 'History');
*/

Select * From Courses;

-- everything with 5 or more
Select Class, Count(*)
From Courses
Group By Class
Having Count(*) >= 5;

-- No duplicate students in a class
Select Class
From Courses
Group By Class
Having Count(Distinct Student) >= 5;

/*
Runtime: 248 ms, faster than 74.67% of MySQL online submissions for Classes More Than 5 Students.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Classes More Than 5 Students.
*/

