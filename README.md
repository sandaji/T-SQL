#Murach Chapter 15 How to Code Triggers

#1:Run the attached script file, "trigger tables.sql", and create a single trigger that will insert rows into the table dd.paytrack. Each time a pledge payment is added, changed, or removed to the table dd.payment the username (logon), current date, action taken (INSERT, UPDATE, or DELETED), and the ipay value for the payment record should be added to the dd.paytrack table. Use the following for your primary key in the dd.paytrack table: idtrack INT NOT NULL IDENTITY PRIMARY KEY

##Use the following three DML statement to test your trigger: INSERT INTO dd.payment VALUES (1479,112,20,'01-JUN-2013','CC');

UPDATE dd.payment SET paymethod = 'YY' WHERE idpay = 1479;

DELETE FROM dd.payment WHERE idpay = 1479;

##Use the following two queries to show and test your work:

select * from dd.Payment where idpay > (SELECT MAX(idpay) - 10 FROM dd.Payment)

select * from dd.paytrack

Trigger Here

Screen Shot Here

#2:Create a trigger to solve the following problem. In a previous assignment you created the following view: 
create or alter view num_3

as select s.student_id, last_name, first_name, se.section_id, description

from db2.hw.student s

join db2.hw.enrollment e on s.student_id = e.STUDENT_ID

join db2.hw.section se on e.section_id=se.SECTION_ID join db2.hw.course c on se.COURSE_NO=c.COURSE_NO;

After you created the view you run the following insert command: INSERT INTO db2.dbo.NUM_3 (student_id, last_name, first_name, section_id, description) values('500', 'Professor', 'Gabor', '80', 'Intro to Programming');

You received an error message: Msg 4405, Level 16, State 1, Line 8

View or function 'db1.dbo.NUM_3' is not updatable because the modification affects multiple base tables.

Just write the trigger so the student_id, last_name, & first_name are inserted correctly!

Trigger Here

Screen Shot Here

#3:Create trigger that will prevent the deletion or altering of a table on the database db2. Note: DO NOT
#code this to eliminate the error for FKs. To test your work use the below two tables.

use db2

go

DROP TABLE dbo.BOOKCAST_AUTHOR

use db2

go

ALTER TABLE dbo.BOOKCAST_AUTHOR ADD DOB DATETIME

Trigger Here

Screen Shot Here
