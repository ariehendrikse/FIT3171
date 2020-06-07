--add set echo and spool command here

/*
Databases Week 11 Tutorial
week11_sql_advanced.sql

student id: 30590566
student name: Arie Hendrikse
last modified date:

*/

/* 1. Find the number of scheduled classes assigned to each staff member each year and semester. 
If the number of classes is 2 then this should be labelled as a correct load, 
more than 2 as an overload and less than 2 as an underload. 
Order the list by decreasing order of scheduled class number. */

SELECT SCHEDCLASS.ofyear,SCHEDCLASS.semester,SCHEDCLASS.staffid
FROM UNI.STAFF INNER JOIN UNI.SCHEDCLASS ON STAFF.STAFFID=SCHEDCLASS.STAFFID;

/* 2. Display unit code and unitname for units that do not have a prerequisite. 
Order the list in increasing order of unit code.

There are many approaches that you can take in writing an SQL statement to answer this query. 
You can use the SET OPERATORS, OUTER JOIN and a SUBQUERY. 
Write SQL statements based on all of these approaches.*/



/* 3. List all units offered in 2013 semester 2 which do not have any scheduled class. 
Include unit code, unit name, and chief examiner name in the list. 
Order the list based on the unit code. */



 
/* 4. List full names of students who are enrolled in both Introduction to Databases and Programming Foundations 
(note: unit names are unique). Order the list by student full name.*/



/* 5. Given that payment rate for tutorial is $42.85 per hour and  payemnt rate for lecture is $75.60 per hour, 
calculate weekly payment per type of class for each staff. 
In the display, include staff name, type of class (lecture or tutorial), 
number of classes, number of hours (total duration), and weekly payment (number of hours * payment rate). 
Order the list by increasing order of staff name*/




/* 6. Assume that all units worth 6 credit points each, calculate each student’s Weighted Average Mark (WAM) and GPA. 
Please refer to these Monash websites: https://www.monash.edu/exams/results/wam and https://www.monash.edu/exams/results/gpa 
for more information about WAM and GPA respectively. 

Calculation example for student 111111111:
WAM = (65x3 + 45x3 + 74x3 +74*6)/(3+3+3+6) = 66.4
GPA = (2x6 + 0.3x6 + 3x6 + 3x6)/(6+6+6+6) = 2.08

Include student id, student full name (in a 40 character wide column headed “Student Full Name”), WAM and GPA in the display. 
Order the list by descending order of WAM then descending order of GPA.
*/


