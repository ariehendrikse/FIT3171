-- Arie Hendrikse
-- 9 May 2020
--Q1
select studid,(studfname || ' ' || studlname) as NAME,to_char(studdob,'DD-MM-YYYY') AS dob from uni.student order by studdob;

--Q2
SELECT studid,(studfname || ' ' || studlname) as NAME,to_char(ofyear,'YYYY') AS year, semester
FROM 
   uni.student NATURAL JOIN uni.enrolment 
WHERE mark IS NULL
order by unitcode,studid;