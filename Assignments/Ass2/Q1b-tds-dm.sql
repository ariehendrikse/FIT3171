--****PLEASE ENTER YOUR DETAILS BELOW****
--Q1b-tds-dm.sql
--Student ID: 30590566
--Student Name: Arie Hendrikse
--Tutorial No: 

SET SERVEROUTPUT ON;
ROLLBACK;
/* Comments for your marker:




*/


/*
1b(i) Create a sequence 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE
DROP SEQUENCE offences_seq;
CREATE SEQUENCE offences_seq
START WITH      100
INCREMENT BY    1
NOCACHE;



/*
1b(ii) Take the necessary steps in the database to record data.
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE
INSERT INTO offence 
VALUES (
        offences_seq.nextval,
        to_date('10-AUG-2019 08:04:00', 'DD-MON-YYYY HH24:MI:SS'),
        '30 Stupid Street, Painsville',
        (SELECT dem_code FROM DEMERIT WHERE dem_description='Blood alcohol charge'),
        10000011,
        100389,
        'JYA3HHE05RA070562');

INSERT INTO offence 
VALUES (
        offences_seq.nextval,
        to_date('16-OCT-2019 21:00:00', 'DD-MON-YYYY HH24:MI:SS'),
        '36 Funny Street, Painsville',
        (SELECT dem_code FROM DEMERIT WHERE dem_description='Level crossing offence'),
        10000015,
        100389,
        'JYA3HHE05RA070562');
INSERT INTO offence 
VALUES (
        offences_seq.nextval,
        to_date('07-JAN-2020 07:07:00', 'DD-MON-YYYY HH24:MI:SS'),
        '36 Funny Street, Painsville',
        (SELECT dem_code FROM DEMERIT WHERE dem_description='Exceeding the speed limit by 25 km/h or more'),
        10000015,
        100389,
        'JYA3HHE05RA070562');

SELECT * from offence;



/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

UPDATE offence 
SET dem_code=   (
                SELECT dem_code 
                FROM demerit 
                WHERE dem_description='Exceeding the speed limit by 10 km/h or more but less than 25 km/h'
                )
WHERE off_datetime=to_date('16-OCT-2019 21:00:00', 'DD-MON-YYYY HH24:MI:SS') and lic_no=100389;--may not be needed as datetie is unique.




