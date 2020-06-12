--****PLEASE ENTER YOUR DETAILS BELOW****
--Q2-tds-queries.sql
--Student ID: 30590566
--Student Name: Arie Hendrikse
--Tutorial No: 
SET SERVEROUTPUT ON;
ROLLBACK;
/* Comments for your marker:




*/


/*
2(i) Query 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT dem_points as "Demerit Points", dem_description as "Demerit Description"
FROM demerit
WHERE upper(dem_description) LIKE '%HEAVY%' OR dem_description LIKE 'Exceed%'
ORDER BY dem_points,dem_description ASC;


/*
2(ii) Query 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT veh_maincolor as "Main Colour", veh_vin as "VIN", TO_CHAR(veh_yrmanuf,'YYYY') as "Year Manufactured"
FROM vehicle
WHERE (veh_modname='Range Rover'
OR veh_modname='Range Rover Sport')
AND veh_yrmanuf BETWEEN TO_DATE('2012', 'YYYY') and TO_DATE('2014', 'YYYY');




/*
2(iii) Query 3
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT  driver.lic_no as "License No.",
        driver.lic_fname ||' ' || lic_lname as "Driver fullname",
        lic_dob as "DOB",
        driver.lic_street || ', ' || driver.lic_town || ', ' || driver.lic_postcode as "Driver Address",
        suspension.sus_date as "Suspended on", suspension.sus_enddate as "Suspended Till"
        
FROM driver JOIN 
suspension
ON suspension.lic_no=driver.lic_no
WHERE suspension.sus_date BETWEEN ADD_MONTHS(SYSDATE, -30) AND SYSDATE
ORDER BY driver.lic_no ASC,suspension.sus_date DESC;




/*
2(iv) Query 4
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT  demerit.dem_code "Demerit Code",demerit.dem_description "Demerit Description",NVL(ytl,0) "Total Offences (All Months)",
        NVL(jan,0) "Jan",NVL(feb,0) "Feb",NVL(mar,0) "Mar",NVL(apr,0) "Apr",NVL(may,0) "May",NVL(jun,0) "Jun",NVL(jul,0) "Jul",NVL(aug,0) "Aug",NVL(sep,0) "Sep",NVL(oct,0) "Oct",NVL(nov,0) "Nov",NVL(dec,0) "Dec" 
FROM demerit FULL JOIN 
            (SELECT  dem_code, COUNT(dem_code) as ytl
                FROM offence
                GROUP BY dem_code)
            ytl on ytl.dem_code=demerit.dem_code
                FULL JOIN
            (SELECT  dem_code, COUNT(dem_code) as jan
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=01) 
            jan on jan.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code, COUNT(dem_code) as feb
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=02) 
            feb ON feb.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as mar
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=03) 
            mar ON mar.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as apr
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=04) 
            apr ON apr.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as may
                FROM offence 
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=05) 
            may ON may.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as jun
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=06) 
            jun ON jun.dem_code=demerit.dem_code
                FULL JOIN
            (SELECT  dem_code, COUNT(dem_code) as jul
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=07) 
            jul ON jul.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as aug
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=08) 
            aug ON aug.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as sep
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=09) 
            sep ON sep.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as oct
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=10) 
            oct ON oct.dem_code=demerit.dem_code
                 FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as nov
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=11) 
            nov ON nov.dem_code=demerit.dem_code
                FULL JOIN
            (SELECT  dem_code,  COUNT(dem_code) as dec
                FROM offence
                GROUP BY dem_code,to_char(off_datetime,'MM')
                HAVING to_char(off_datetime,'MM')=12) 
            dec ON dec.dem_code=demerit.dem_code
ORDER BY NVL(ytl,0) DESC;



/*
2(v) Query 5
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT vehicle.veh_manufname, COUNT(*) as "Total No. of Offences"
FROM offence join vehicle on offence.veh_vin=vehicle.veh_vin join demerit on demerit.dem_code=offence.dem_code
WHERE demerit.dem_points>=2
GROUP BY vehicle.veh_manufname
ORDER BY COUNT(*) DESC;




/*
2(vi) Query 6
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT driver.lic_no "Licence No.", driver.lic_fname || ' ' || driver.lic_lname "Driver Name", officer.officer_id "Officer ID", officer.officer_fname || ' ' || officer.officer_lname "Officer Name"
FROM driver join offence on driver.lic_no=offence.lic_no join officer on offence.officer_id=offence.officer_id
WHERE officer.officer_lname = driver.lic_lname
HAVING COUNT(*)>1
GROUP BY driver.lic_no, driver.lic_fname,driver.lic_lname, officer.officer_id, officer.officer_fname,officer.officer_lname,offence.dem_code
ORDER BY driver.lic_no ASC;




/*
2(vii) Query 7
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
SELECT w.a "Demerit Code", q.b "Demerit Description",q.c "Licence No.",q.d "Driver Fullname",w.b "Total Times Booked"
FROM(
    SELECT a, MAX(cnt) b
        FROM 
        (SELECT demerit.dem_code a,COUNT(*) cnt
            FROM offence join demerit on demerit.dem_code=offence.dem_code join driver on driver.lic_no = offence.lic_no
            GROUP BY demerit.dem_code,driver.lic_no,driver.lic_fname,driver.lic_lname,demerit.dem_description)
            GROUP BY a
            ORDER BY a) w
        
    JOIN 
        
        (SELECT demerit.dem_code a, demerit.dem_description b, driver.lic_no c,driver.lic_fname || ' ' || driver.lic_lname d,COUNT(*) cnt
            FROM offence join demerit on demerit.dem_code=offence.dem_code join driver on driver.lic_no = offence.lic_no
            GROUP BY demerit.dem_code,driver.lic_no,driver.lic_fname,driver.lic_lname,demerit.dem_description) q
    ON q.a=w.a
WHERE w.b =q.cnt
ORDER BY w.a;


/*
2(viii) Query 8
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE



        
SELECT  r "Region", count(region.r)  "Total Vehicle's Manufactured", round(count(region.r)/ (SELECT COUNT(*) FROM vehicle)*100.00,2) "Percentage"
FROM  
(SELECT (CASE 
    WHEN veh_vin BETWEEN 'A' and 'C' THEN 'Africa'
    WHEN veh_vin BETWEEN 'J' and 'R' THEN 'Asia'
    WHEN veh_vin BETWEEN 'S' and 'Z' THEN 'Europe'
    WHEN veh_vin BETWEEN '1' and '5' THEN 'North America'
    WHEN veh_vin BETWEEN '6' and '7' THEN 'Oceania'
    WHEN veh_vin BETWEEN '8' and '9' THEN 'South America'
    ELSE 'Unknown'
END) AS r
FROM vehicle v ORDER BY count(r)) region
GROUP BY region.r

UNION
SELECT 'Total',SUM(COUNT(smry.r)),SUM(ROUND(COUNT(smry.r)/(SELECT COUNT(*) FROM vehicle)*100,2)) FROM 
(SELECT (CASE 
    WHEN veh_vin BETWEEN 'A' and 'C' THEN 'Africa'
    WHEN veh_vin BETWEEN 'J' and 'R' THEN 'Asia'
    WHEN veh_vin BETWEEN 'S' and 'Z' THEN 'Europe'
    WHEN veh_vin BETWEEN '1' and '5' THEN 'North America'
    WHEN veh_vin BETWEEN '6' and '7' THEN 'Oceania'
    WHEN veh_vin BETWEEN '8' and '9' THEN 'South America'
    ELSE 'Unknown'
END) as r
FROM vehicle v) smry
GROUP BY smry.r
;























