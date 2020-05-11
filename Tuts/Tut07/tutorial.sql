
set echo on
spool week7_schema_output.txt
drop table enrolment purge;
drop table student purge;
drop table unit purge;


create table student
    (
        stu_nbr     numeric(8),
        stu_lname   varchar(50) NOT NULL,
        stu_fname   varchar(50) NOT NULL,
        stu_dob     date NOT NULL,
        CONSTRAINT min_stu_nbr CHECK (stu_nbr >= 1000000),
        CONSTRAINT student_pk PRIMARY KEY ( stu_nbr )
    )   ;

create table unit
    (
        unit_code char(7) not null,
        unit_name varchar(50) not null,
        constraint unit_pk PRIMARY KEY ( unit_code )
    )   ;

create table enrolment
    (
        stu_nbr         numeric(8) NOT NULL,
        unit_code       char(7) NOT NULL,
        enrol_year      numeric(4) NOT NULL,
        enrol_semester  char(1) NOT NULL,
        enrol_mark      numeric(3),
        enrol_grade     char(2),
        constraint enrol_pk PRIMARY KEY ( stu_nbr, unit_code ),
        constraint unit_fk foreign key ( unit_code )
            references unit ( unit_code ) on delete set null,
        constraint stu_fk foreign key ( stu_nbr )
            references student ( stu_nbr ) on delete set null
    )   ;
INSERT INTO student 
    (
        stu_nbr, stu_lname, stu_fname, stu_dob
    )
    WITH names AS
        (SELECT 11111111, 'Bloggs', 'Fred', '1-Jan-90' FROM dual UNION ALL 
        SELECT 11111112, 'Nice', 'Nick', '10-Oct-94' FROM dual UNION ALL 
        SELECT 11111113, 'Wheat', 'Wendy', '5-May-90' FROM dual UNION ALL
        SELECT 11111114, 'Sheen', 'Cindy', '25-Dec-96' FROM dual)
    SELECT * FROM names
    ;
    
INSERT INTO unit 
    (
         unit_code,unit_name
    )
    WITH names AS
        (SELECT 'FIT9999','FIT Last Unit' FROM dual UNION ALL 
        SELECT 'FIT5132','Introduction to Databases' FROM dual UNION ALL 
        SELECT 'FIT5016','Project' FROM dual UNION ALL 
        SELECT 'FIT5111','Students Life' FROM dual)
    SELECT * FROM names
    ;
    
INSERT INTO enrolment
       (stu_nbr ,unit_code,enrol_year,enrol_semester,enrol_mark,enrol_grade)
    WITH names AS
         (SELECT 11111111,'FIT5132',2013,1 ,35,'N' FROM dual UNION ALL 
         SELECT 11111111, 'FIT5016',2013,1,61,'C' FROM dual UNION ALL 
         SELECT 11111111, 'FIT5132',2013,2,42,'N' FROM dual UNION ALL 
         SELECT 11111111, 'FIT5111',2013,2,76,'D' FROM dual UNION ALL 
         SELECT 11111111, 'FIT5132',2014,2,NULL,NULL FROM dual UNION ALL 
         SELECT 11111111,'FIT5132',2013,2,83,'HD' FROM dual UNION ALL 
         SELECT 11111112,'FIT5111',2013,2,79,'D' FROM dual UNION ALL 
         SELECT 11111113,'FIT5132',2014,2,NULL,NULL FROM dual UNION ALL 
         SELECT 11111113,'FIT5111',2014,2,NULL,NULL FROM dual UNION ALL 
         SELECT 11111114,'FIT5111',2014,2,NULL,NULL FROM dual)
         SELECT * FROM names;




        


SELECT * FROM student;
commit;
spool off
set echo off