spool week9_schema_output.txt
set echo on


UPDATE UNIT
SET UNIT_NAME = 'place holder unit'
WHERE UNIT_CODE = 'FIT9999';

--Enter the mark and grade for the student with the student number of 11111113 for the unit
--code FIT5132 that the student enrolled in semester 2 of 2014. The mark is 75 and the grade
--is D.

UPDATE enrolment
set enrol_mark = 75
where stu_nbr = 11111113 and
unit_code='FIT5132' and
enrol_semester = 2
and enrol_year = 2014;

UPDATE enrolment
set enrol_grade = 'D'
where stu_nbr = 11111113 and
unit_code='FIT5132' and
enrol_semester = 2
and enrol_year = 2014;

UPDATE enrolment
set enrol_grade = 'P1'
where enrol_mark BETWEEN 45 and 54;

UPDATE enrolment
set enrol_grade = 'P2'
where enrol_mark BETWEEN 55 and 64;

UPDATE enrolment
set enrol_grade = 'C'
where enrol_mark BETWEEN 65 and 74;

UPDATE enrolment
set enrol_grade = 'D'
where enrol_mark BETWEEN 74 and 84;

UPDATE enrolment
set enrol_grade = 'HD'
where enrol_mark BETWEEN 85 and 100;

DELETE FROM ENROLMENT
WHERE stu_nbr = 11111114 and
enrol_semester = 2 and
enrol_year = 2014;

DELETE FROM STUDENT
WHERE stu_nbr = '11111113';

insert into student values (11111113,'Wheat','Wendy','05-May-1990');

ALTER TABLE ENROLMENT DROP CONSTRAINT fk_enrolment_unit;

ALTER TABLE ENROLMENT DROP CONSTRAINT fk_enrolment_student;

ALTER TABLE ENROLMENT ADD CONSTRAINT fk_enrolment_student foreign key (stu_nbr)
      references student (stu_nbr) on delete cascade;
      
ALTER TABLE ENROLMENT ADD CONSTRAINT fk_enrolment_unit foreign key (unit_code)
      references unit (unit_code) on delete cascade;
      
DELETE FROM STUDENT
WHERE stu_nbr = '11111113';



commit;
set echo off
spool off