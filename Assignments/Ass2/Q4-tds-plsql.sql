--****PLEASE ENTER YOUR DETAILS BELOW****
--Q4-tds-plsql.sql
--Student ID: 30590566
--Student Name: Arie hendrikse
--Tutorial No: 
ROLLBACK;
/* Comments for your marker:




*/

/* (i) Write a trigger which will, from this point forward, automatically maintain the total number of times each police officer has booked a driver for a traffic offence attribute you added in Task 3. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/


CREATE OR REPLACE TRIGGER maintain_offence_count
BEFORE INSERT OR UPDATE OR DELETE ON offence
    FOR EACH ROW

BEGIN
    IF INSERTING THEN
        UPDATE officer SET officer_no_booking=officer_no_bookings+1
        WHERE officer_no = :new.officer_no;
        DBMS_OUTPUT.PUT_LINE ('New offence ' || :new.off_no ||
            ' has been added to officers total bookings for officer' || :new.officer_no);
    ELSE
        IF DELETING
            THEN
                update officer set officer_no_booking=officer_no_bookings-1
                where officer_no = :old.officer_no;
            ELSE
                IF UPDATING THEN
                    UPDATE officer
                        SET officer_no_bookings = officer_no_booking - 1
                        where officer_no = :old.officer_no;
                    UPDATE DEPARTMENT
                        SET officer_no_bookings = officer_no_bookings + 1
                        where officer_no = :new.officer_no;
                    DBMS_OUTPUT.PUT_LINE ('The officer ' || :old.officer_no ||
                    ' has been changed on offience ' || :old.offence_no ||
                    ' to new officer ' || :new.officer_no);
            END IF;
        END IF;
    END IF;
END;
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

INSERT INTO offence VALUES (33,to_date('21-JUN-2019 23:05:58', 'DD-MON-YYYY HH24:MI:SS'),'Melton',104,10000015,100213,'ZHWGE6BZ3DLA12625');

SELECT
    *
FROM
    officer;

SELECT
    *
FROM
    offence;
    
---- Move OFFENCE-------

UPDATE offence
SET
	officer_no = 10000015
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
	off_no = 1;

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









/* (iii) The local government wants to maintain a history of all drivers’ license expiry dates. Write a trigger to record the current and new lic_expiry date of a driver’s license whenever there is a change in a driver’s license expiry date. The trigger must check if the new licence expiry date is at least 30 months (2.5 years) later than current license expiry date, otherwise it must prevent the change.
Hint: to carry out this task, you need to create another table where the history of all drivers’ license expiry dates is recorded. In the table, include the licence number, the current expiry date, the new expiry date and the date when the update is done.
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
