set echo on
spool week8_SQLBasic_PartB_output.txt

/*
Databases Week 8 Tutorial Sample Solution
week8_SQLBasic_PartB.sql

student id: 30590566
student name: arie hendrikse
last modified date:
*/

/* B1. List all the unit codes, semester and name of the chief examiner for all 
      the units that are offered in 2014.*/
SELECT UNITCODE,CHIEFEXAM,SEMESTER,STAFFFNAME || ' ' || STAFFLNAME as CHIEFNAME
FROM UNI.offering JOIN uni.STAFF ON offering.CHIEFEXAM=staff.STAFFID
WHERE to_char(ofyear,'yyyy')='2014';

  

/* B2. List all the unit codes and the unit names and their year and semester 
      offerings. To display the date correctly in Oracle, you need to use to_char function. 
      For example, to_char(ofyear,'YYYY'). */
SELECT UNIT.UNITCODE,UNITNAME,to_char(ofyear,'yyyy'),SEMESTER
FROM UNI.OFFERING JOIN UNI.UNIT 
    ON OFFERING.UNITCODE=UNIT.UNITCODE;
  

/* B3. List the unit code, semester, class type (lecture or tutorial), 
      day and time for all units taught by Albus Dumbledore in 2013. 
      Sort the list according to the unit code.*/
SELECT SCHEDCLASS.UNITCODE,SEMESTER,CLTYPE,CLDAY,CLTIME
FROM UNI.SCHEDCLASS JOIN UNI.STAFF ON SCHEDCLASS.STAFFID=STAFF.STAFFID
WHERE STAFF.STAFFFNAME = 'Albus' and STAFF.STAFFLNAME = 'Dumbledore' and to_char(ofyear,'yyyy')='2013';


/* B4. Create a study statement for Mary Smith. A study statement contains 
      unit code, unit name, semester and year study was attempted, the mark 
      and grade. */
SELECT UNIT.UNITCODE,UNITNAME,to_char(OFYEAR,'yyyy')  as YEAR,SEMESTER,MARK,GRADE
FROM UNI.ENROLMENT JOIN UNI.STUDENT 
    ON ENROLMENT.STUDID=STUDENT.STUDID JOIN UNI.UNIT 
        ON UNIT.UNITCODE = ENROLMENT.UNITCODE
WHERE STUDENT.STUDFNAME = 'Mary' and STUDENT.STUDLNAME = 'Smith';


/* B5. List the unit code and unit name of the pre-requisite units of 
      'Advanced Data Management' unit */
SELECT 
    UNITCODE,
    UNITNAME
FROM 
    (
    SELECT
        *
    FROM 
        UNI.PREREQ, JOIN UNI.UNIT ON PREREQ.UNITCODE=UNIT.UNITCODE
    WHERE UNIT.UNITNAME='Advanced Data Management'
    
    ) AS U
    JOIN UNI.UNIT WHERE 
    ;

WHERE UNITNAME='Advanced Data Management' JOIN UNI.UNIT WHERE PREREQ.HAS_PREREQ_OF=U.UNITCODE;


/* B6. Find all students (list their id, firstname and surname) who 
       have a failed unit in the year 2013 */
SELECT STUDENT.STUDID, STUDFNAME,STUDLNAME
FROM UNI.STUDENT JOIN UNI.ENROLMENT ON STUDENT.STUDID=ENROLMENT.STUDID
WHERE to_char(ENROLMENT.OFYEAR,'yyyy')='2013' and GRADE='N';


/* B7.	List the student name, unit code, semester and year for those 
        students who do not have marks recorded */
SELECT STUDFNAME || ' ' || STUDLNAME as NAME , UNITCODE, SEMESTER
FROM UNI.ENROLMENT JOIN UNI.STUDENT ON ENROLMENT.STUDID=STUDENT.STUDID
WHERE GRADE IS NULL;

spool off
set echo off
