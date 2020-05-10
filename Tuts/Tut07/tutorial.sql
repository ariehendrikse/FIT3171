drop table student purge;
drop table unit purge;
drop table enrolment purge;
set echo on
spool week7_schema_output.txt

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
        enrol_mark      numeric(3) NOT NULL,
        enrol_grade     char(2) NOT NULL,
        constraint enrol_pk PRIMARY KEY ( stu_nbr, unit_code ),
        constraint unit_fk foreign key ( unit_code )
            references unit ( unit_code ) on delete set null,
        constraint stu_fk foreign key ( stu_nbr )
            references student ( stu_nbr ) on delete set null
    )   ;

commit;
spool off
set echo off