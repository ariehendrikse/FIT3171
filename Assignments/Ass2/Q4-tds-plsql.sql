--****PLEASE ENTER YOUR DETAILS BELOW****
--Q4-tds-plsql.sql
--Student ID: 30590566
--Student Name: Arie hendrikse
--Tutorial No: 
ROLLBACK;

/* Comments for your marker:

This is throwing an error for me saying that I have an invalid ientifier on line 181. the error is part of code thtat I have already deleted. It is creating a demerit table however that code has been deleted and I still get the err
so please look out for that


*/

/* (i) Write a trigger which will, from this point forward, automatically maintain the total number of times each police officer has booked a driver for a traffic offence attribute you added in Task 3. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

--Trigger declaration

COMMIT;
CREATE OR REPLACE TRIGGER maintain_officer_bookings
BEFORE DELETE OR INSERT OR UPDATE ON offence
FOR EACH ROW
BEGIN
  -- Trigger to automatically maintain the offence count in
    -- the officer table

    -- for inserts, increase offence count in officer:
    IF INSERTING THEN
    	UPDATE officer
    	    SET officer_no_bookings = officer_no_bookings + 1
    	    where officer_id = :new.officer_id;
            DBMS_OUTPUT.PUT_LINE ('New offence ' || :new.off_no ||
            ' has been added to officer ' || :new.officer_id);

    -- for deletes, decrease bookings count in officer:
    ELSE
        IF DELETING THEN
     	    UPDATE officer
    	        SET officer_no_bookings = officer_no_bookings - 1
    	        where officer_id = :old.officer_id;
                DBMS_OUTPUT.PUT_LINE ('Old offence ' || :old.off_no ||
                ' has been deleted from officer ' || :old.officer_id);

        -- for updates ie moves, modify the bookings count in officer:
        ELSE
            IF UPDATING THEN
      	        UPDATE officer
    	            SET officer_no_bookings = officer_no_bookings - 1
    	            where officer_id = :old.officer_id;
    	        UPDATE officer
    	            SET officer_no_bookings = officer_no_bookings + 1
    	            where officer_id = :new.officer_id;
                DBMS_OUTPUT.PUT_LINE ('The officer ' || :new.officer_id ||
                ' has been moved from offence ' || :old.off_no );
            END IF;
        END IF;
     END IF;
END;
/
COMMIT;
--Test--
SELECT
    *
FROM
    officer;

SELECT
    *
FROM
    offence;

INSERT INTO offence VALUES (33,to_date('30-JUN-2019 24:59:58', 'DD-MON-YYYY HH24:MI:SS'),'Melton',104,10000015,100213,'ZHWGE6BZ3DLA12625');

SELECT
    *
FROM
    officer;

SELECT
    *
FROM
    offence;
    
---- Update OFFENCE-------

UPDATE offence
SET
	officer_id = 10000015
WHERE
	off_no = 3;

SELECT
    *
FROM
    officer;

SELECT
    *
FROM
    offence;

--- Delete OFFENCE ---
DELETE FROM offence
WHERE
	off_no = 2;

SELECT
    *
FROM
    officer;

SELECT
    *
FROM
    offence;
ROLLBACK;


/* (ii) Write a trigger which will, from this point forward, make sure that driver and police have at least one name before their data is added into the database. The trigger must prevent the insertion if both names are nulls. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

CREATE OR REPLACE TRIGGER check_driver_names
BEFORE UPDATE OR INSERT ON driver
FOR EACH ROW
BEGIN
  IF((:new.lic_fname IS NULL) AND (:new.lic_lname IS NULL))
  THEN
    RAISE_APPLICATION_ERROR( -20003, 
                             'The driver needs at least one name' );
  END IF;
END;
/

CREATE OR REPLACE TRIGGER check_officer_names
BEFORE UPDATE OR INSERT ON officer
FOR EACH ROW

BEGIN
  IF((:new.officer_fname IS NULL) AND (:new.officer_lname IS NULL) )
  THEN
    RAISE_APPLICATION_ERROR( -20004, 
                             'The officer needs at least one name' );
  END IF;
END;
/
--Test--
--Insert Offence
SELECT
    *
FROM
    officer;


INSERT INTO officer VALUES (10000040, null,null );

SELECT
    *
FROM
    officer;

INSERT INTO driver VALUES ('100999', null, null, '0499999998', '819 Bultman Street', 'Attwood', '3049', TO_DATE('19-Nov-1962', 'DD-MON-YYYY'), TO_DATE('20-May-2027', 'DD-MON-YYYY'));

SELECT
    *
FROM
    driver;
    
---- Update Driver abnd officer-------
UPDATE officer
SET officer_fname=null, officer_lname=null
WHERE officer_id=10000010;

UPDATE officer
SET officer_fname='Mark', officer_lname=null
WHERE officer_id=10000011;

SELECT
    *
FROM
    officer;
UPDATE driver
SET lic_fname=null, lic_lname=null
WHERE lic_no=100015;

UPDATE driver
SET lic_fname='Steve', lic_lname=null
WHERE lic_no=100016;


SELECT
    *
FROM
    driver;

ROLLBACK;






/* (iii) The local government wants to maintain a history of all drivers’ license expiry dates. Write a trigger to record the current and new lic_expiry date of a driver’s license whenever there is a change in a driver’s license expiry date. The trigger must check if the new licence expiry date is at least 30 months (2.5 years) later than current license expiry date, otherwise it must prevent the change.
Hint: to carry out this task, you need to create another table where the history of all drivers’ license expiry dates is recorded. In the table, include the licence number, the current expiry date, the new expiry date and the date when the update is done.
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE TABLE expiry (
    lic_no         CHAR(10) NOT NULL,
    lic_expiry     DATE NOT NULL
);

COMMENT ON COLUMN expiry.lic_no IS
    'License Number (unique)';

COMMENT ON COLUMN expiry.lic_expiry IS
    'Expiry date of license';
ALTER TABLE expiry ADD CONSTRAINT expiry_pk PRIMARY KEY ( lic_no );
ALTER TABLE expiry
    ADD CONSTRAINT expiry_license FOREIGN KEY ( lic_no )
        REFERENCES driver ( lic_no );



CREATE OR REPLACE TRIGGER maintain_expiry_dates
BEFORE UPDATE of lic_expiry ON expiry
FOR EACH ROW

BEGIN
  IF( ADD_MONTHS(:old.lic_expiry,30)>=:new.lic_expiry )
  THEN
    RAISE_APPLICATION_ERROR( -20002, 
                             'The new expiry value must be 30 months after the old one' );
  END IF;
END;
/
COMMIT;
INSERT INTO expiry VALUES (100001,to_date('20-AUG-2013 14:05:53', 'DD-MON-YYYY HH24:MI:SS'));
UPDATE expiry
SET lic_expiry = to_date('20-AUG-2014 14:05:53', 'DD-MON-YYYY HH24:MI:SS')
WHERE lic_no=100001;
--Test update of expiry
SELECT
    *
FROM
    expiry;
ROLLBACK;
--Test valid date
INSERT INTO expiry VALUES (100002,to_date('20-AUG-2013 14:05:53', 'DD-MON-YYYY HH24:MI:SS'));
UPDATE expiry
SET lic_expiry = to_date('20-AUG-2017 14:05:53', 'DD-MON-YYYY HH24:MI:SS')
WHERE lic_no=100002;
SELECT
    *
FROM
    expiry;

ROLLBACK;





