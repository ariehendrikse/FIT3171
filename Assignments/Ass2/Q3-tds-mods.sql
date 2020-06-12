--****PLEASE ENTER YOUR DETAILS BELOW****
--Q3-tds-mods.sql
--Student ID: 30590566
--Student Name: Arie Hendrikse
--Tutorial No: 

/* Comments for your marker:




*/

ROLLBACK;
/*
3(i) Changes to live database 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

ALTER TABLE officer
ADD officer_no_bookings NUMERIC(8);

UPDATE officer a
SET officer_no_bookings = (SELECT COUNT(*) FROM offence b where a.officer_id = b.officer_id);
COMMIT;
SELECT * FROM OFFICER;
/*
3(ii) Changes to live database 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

ALTER TABLE offence
ADD off_revoked VARCHAR(3) DEFAULT 'No';
ALTER TABLE offence
ADD off_revok_desc CHAR(3);
COMMIT;
SELECT * from offence;










































