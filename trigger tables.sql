 drop database Trigger_Tables;
create database Trigger_Tables;
go
use [Trigger_Tables];
go
CREATE SCHEMA DD AUTHORIZATION dbo;
GO 
drop TABLE if exists dd.Donor; 
CREATE TABLE dd.Donor (
	idDonor int,
	Firstname nvarchar(15),
	Lastname nvarchar(30),
    Typecode CHAR(1),
	Street nvarchar(40),
	City nvarchar(20),
	State char(2),
	Zip nvarchar(9),
	Phone nvarchar(10),
	Fax nvarchar(10),
	Email nvarchar(25),
                  News char(1),
	dtentered date DEFAULT getdate(),
	CONSTRAINT donor_id_pk PRIMARY KEY(idDonor) );


drop TABLE if exists dd.Project; 
CREATE TABLE dd.Project (
                   idProj int,
                   Projname nvarchar(60),
                   Projstartdate DATE,
                   Projenddate DATE,
                   Projfundgoal decimal(12,2),
                   ProjCoord nvarchar(20),
                   CONSTRAINT project_id_pk PRIMARY KEY(idProj),
                   CONSTRAINT project_name_uk  UNIQUE (Projname)  );     
				   
drop TABLE if exists dd.Status; 
CREATE TABLE dd.Status (
                   idStatus int,
                   Statusdesc nvarchar(15),
                   CONSTRAINT status_id_pk PRIMARY KEY(idStatus) );  
				   
drop TABLE if exists dd.Pledge; 
CREATE TABLE dd.Pledge (
                   idPledge int,
                   idDonor int,
                   Pledgedate DATE,
                   Pledgeamt decimal(8,2),
                   idProj int,
                   idStatus int,
                   Writeoff decimal(8,2),
                   paymonths int,
                   Campaign int,
                   Firstpledge char(1),
                   CONSTRAINT pledge_id_pk PRIMARY KEY(idPledge),
                   CONSTRAINT pledge_idDonor_fk FOREIGN KEY (idDonor)
                           REFERENCES dd.donor (idDonor), 
                   CONSTRAINT pledge_idProj_fk FOREIGN KEY (idProj)
                           REFERENCES dd.project (idProj),
                   CONSTRAINT pledge_idStatus_fk FOREIGN KEY (idStatus)
                           REFERENCES dd.status (idStatus)); 
						   
 drop TABLE if exists dd.Payment; 
CREATE TABLE dd.Payment (
                   idPay int,
                   idPledge int,
                   Payamt decimal(8,2),
                   Paydate DATE,
                   Paymethod char(2),
                   CONSTRAINT payment_id_pk PRIMARY KEY(idPay),
                   CONSTRAINT pay_idpledge_fk FOREIGN KEY (idPledge)
                   REFERENCES dd.pledge (idPledge) );

go
INSERT INTO dd.donor  
  VALUES (301, 'Mary', 'Treanor', 'I','243 main St.', 'Norfolk', 'VA','23510',NULL,NULL,'mtrea492@mdv.com','Y','01-SEP-2012');
INSERT INTO dd.donor  
  VALUES (302, 'Patrick', 'Lee', 'I','11 Hooper St.', 'Norfolk', 'VA','23510','7572115445',NULL,'pleeNorf@gmail.com','N','09-SEP-2012');
INSERT INTO dd.donor  
  VALUES (303, 'Terry', 'Venor', 'I','556 Loop Lane.', 'Chesapeake', 'VA','23320',NULL,NULL,'tervenr@drw.edu','Y','18-SEP-2012');
INSERT INTO dd.donor  
  VALUES (304, 'Sherry', 'Pane', 'I','Center Blvd.', 'Virginia Beach', 'VA','23455',NULL,NULL,'toppane@yahoo.com','Y','21-SEP-2012');
INSERT INTO dd.donor  
  VALUES (305, 'Thomas', 'Sheer', 'I','66 Train St.', 'Chesapeake', 'VA','23322','7579390022',NULL,'tls3488@sheer.com','Y','01-MAR-2013');
INSERT INTO dd.donor  
  VALUES (306, NULL, 'Coastal Developers', 'B','3667 Shore Dr.', 'Virginia Beach', 'VA','23450','8889220004',NULL,'coastVA@cdev.com','Y','30-SEP-2012');
INSERT INTO dd.donor  
  VALUES (307, NULL, 'VA Community Org', 'G','689 Bush Dr.', 'Norfolk', 'VA','23513','7578337467','7578337468','vacmorg@biz.com','Y','03-OCT-2012');
INSERT INTO dd.donor  
  VALUES (308, 'Betty', 'Konklin', 'I','11 Shark Ln.', 'Virginia Beach', 'VA','23455','7574550087',NULL,'shark11@cox.net','N','04-OCT-2012');
INSERT INTO dd.donor  
  VALUES (309, 'Jim', 'Tapp', 'I','200 Pine Tree Blvd.', 'Chesapeake', 'VA','23320','',NULL,'','N','08-OCT-2012');
INSERT INTO dd.donor  
  VALUES (310, NULL, 'Unique Dezigns', 'B','Connect Circle Unit 12', 'Chesapeake', 'VA','23320','7574442121',NULL,'UDezigns@cox.net','Y','11-SEP-2012');
INSERT INTO dd.project
  VALUES (500,'Elders Assistance League', '01-SEP-2012','31-OCT-2012',15000,'Shawn Hasee');
INSERT INTO dd.project
  VALUES (501,'Community food pantry #21 freezer equipment', '01-OCT-2012','31-DEC-2012',65000,'Shawn Hasee');
INSERT INTO dd.project
  VALUES (502,'Lang Scholarship Fund', '01-JAN-2013','01-NOV-2013',100000,'Traci Brown');
INSERT INTO dd.project
  VALUES (503,'Animal shelter Vet Connect Program', '01-DEC-2012','30-MAR-2013',25000,'Traci Brown');
INSERT INTO dd.project
  VALUES (504,'Shelter Share Project 2013', '01-FEB-2013','31-JUL-2013',35000,'Traci Brown');
INSERT INTO dd.status
  VALUES (10,'Open');
INSERT INTO dd.status
  VALUES (20,'Complete');
INSERT INTO dd.status
  VALUES (30,'Overdue');
INSERT INTO dd.status
  VALUES (40,'Closed');
INSERT INTO dd.status
  VALUES (50,'Hold');
INSERT INTO dd.pledge
   VALUES (100,303,'18-SEP-2012',80,500,20,NULL,0,738,'Y');
INSERT INTO dd.pledge
   VALUES (101,304,'21-SEP-2012',35,500,20,NULL,0,738,'Y');
INSERT INTO dd.pledge
   VALUES (102,310,'01-OCT-2012',500,501,20,NULL,0,749,'Y');
INSERT INTO dd.pledge
   VALUES (103,307,'03-OCT-2012',2000,501,20,NULL,0,749,'N');
INSERT INTO dd.pledge
   VALUES (104,308,'04-OCT-2012',240,501,10,NULL,12,749,'Y');
INSERT INTO dd.pledge
   VALUES (105,309,'08-OCT-2012',120,501,10,NULL,12,749,'Y');
INSERT INTO dd.pledge
   VALUES (106,301,'12-OCT-2012',75,500,20,NULL,0,738,'N');
INSERT INTO dd.pledge
   VALUES (107,302,'15-OCT-2012',1200,501,10,NULL,24,749,'Y');
INSERT INTO dd.pledge
   VALUES (108,308,'20-JAN-2013',480,503,10,NULL,24,790,'N');
INSERT INTO dd.pledge
   VALUES (109,301,'01-FEB-2013',360,503,10,NULL,12,790,'N');
INSERT INTO dd.pledge
   VALUES (110,303,'01-MAR-2013',300,504,10,NULL,12,756,'N');
INSERT INTO dd.pledge
   VALUES (111,306,'01-MAR-2013',1500,504,20,NULL,0,756,'Y');
INSERT INTO dd.pledge
   VALUES (112,309,'16-MAR-2013',240,504,10,NULL,12,756,'N');
INSERT INTO dd.payment
   VALUES (1425,100,80,'18-SEP-2012','CC');
INSERT INTO dd.payment
   VALUES (1426,101,35,'21-SEP-2012','DC');
INSERT INTO dd.payment
   VALUES (1427,102,500,'01-OCT-2012','CH');
INSERT INTO dd.payment
   VALUES (1428,103,2000,'03-OCT-2012','CH');
INSERT INTO dd.payment
   VALUES (1429,106,75,'12-OCT-2012','CC');
INSERT INTO dd.payment
   VALUES (1430,104,20,'01-NOV-2012','CC');
INSERT INTO dd.payment
   VALUES (1431,105,10,'01-NOV-2012','CC');
INSERT INTO dd.payment
   VALUES (1432,107,50,'01-NOV-2012','CC');
INSERT INTO dd.payment
   VALUES (1433,104,20,'01-DEC-2012','CC');
INSERT INTO dd.payment
   VALUES (1434,105,10,'01-DEC-2012','CC');
INSERT INTO dd.payment
  VALUES (1435,107,50,'01-DEC-2012','CC');
INSERT INTO dd.payment
   VALUES (1436,104,20,'01-JAN-2013','CC');
INSERT INTO dd.payment
   VALUES (1437,105,10,'01-JAN-2013','CC');
INSERT INTO dd.payment
   VALUES (1438,107,50,'01-JAN-2013','CC');
INSERT INTO dd.payment
   VALUES (1439,104,20,'01-FEB-2013','CC');
INSERT INTO dd.payment
   VALUES (1440,105,10,'01-FEB-2013','CC');
INSERT INTO dd.payment
   VALUES (1441,107,50,'01-FEB-2013','CC');
INSERT INTO dd.payment
   VALUES (1442,108,20,'01-FEB-2013','CC');
INSERT INTO dd.payment
   VALUES (1443,109,30,'01-FEB-2013','CC');
INSERT INTO dd.payment
   VALUES (1444,104,20,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1445,105,10,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1446,107,50,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1447,108,20,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1448,109,30,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1449,110,25,'01-MAR-2013','CC');
INSERT INTO dd.payment
   VALUES (1450,111,1500,'01-MAR-2013','CH');
INSERT INTO dd.payment
   VALUES (1451,104,20,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1452,105,10,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1453,107,50,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1454,108,20,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1455,109,30,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1456,110,25,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1457,112,20,'01-APR-2013','CC');
INSERT INTO dd.payment
   VALUES (1458,104,20,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1459,105,10,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1460,107,50,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1461,108,20,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1462,109,30,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1463,110,25,'01-MAY-2013','CC');
INSERT INTO dd.payment
   VALUES (1464,112,20,'01-MAY-2013','CC');
 go 
 
 				   
 drop TABLE if exists dd.paytrack;   
   CREATE TABLE dd.paytrack
  (idtrack INT  NOT NULL  IDENTITY  PRIMARY KEY, 
   ptuser VARCHAR(30),
   ptdate DATETIME NOT NULL,
   ptaction VARCHAR(60) NOT NULL, 
   ptpayid int, 
   );
 
  
 --go
 --create trigger paytrackInserted on dd.payment
 --after insert
 --as
 --BEGIN
 --SET NOCOUNT ON;
 --declare @ptpayid int  
 --SELECT @ptpayid = inserted.idPay
 --from inserted

 --insert into dd.paytrack values( user, GETDATE(),'inserted',@ptpayid)

 --end;

 -- go
 --create trigger paytrackDeleted on dd.payment
 --after delete
 --as
 --BEGIN
 --SET NOCOUNT ON;
 --declare @ptpayid int  
 --SELECT @ptpayid = deleted.idPay
 --from deleted

 --insert into dd.paytrack values( user, GETDATE(),'deleted',@ptpayid)

 --end;

 -- go
 --create trigger paytrackUpdated on dd.payment
 --after update
 --as
 --BEGIN
 --SET NOCOUNT ON;
 --declare @ptpayid int  
 --SELECT @ptpayid = inserted.idPay
 --from inserted

 --insert into dd.paytrack values( user, GETDATE(),'updated',@ptpayid)

 --end;

   go
  
 drop trigger  dd.paytrackTrigger 
 go
 create trigger paytrackTrigger on dd.payment
AFTER update, delete, insert
 as
 BEGIN
    SET NOCOUNT ON;
 declare @ptpayid int  
 declare @action nvarchar(50) 

  SELECT @ptpayid = inserted.idPay
 from inserted

  SELECT @ptpayid = deleted.idPay
 from deleted

 IF exists (SELECT * FROM INSERTED) and exists (SELECT * FROM deleted)
  BEGIN 
      SET @action='Updated'
  END

 ELSE IF EXISTS (SELECT * FROM INSERTED) and NOT exists (SELECT * FROM deleted)
  BEGIN 
      SET @action='Inserted'
  END
  
 ELSE IF EXISTS (SELECT * FROM deleted) and NOT exists (SELECT * FROM INSERTED)
  BEGIN 
      SET @action='Deleted'
  END

 ELSE  
   BEGIN 
      SET @action='null';
	  return;
  END
 

 insert into dd.paytrack values( user, GETDATE(),@action,@ptpayid)

 end;
  
  
  INSERT INTO dd.payment  VALUES (1479,112,20,'01-JUN-2013','CC');

  UPDATE dd.payment SET paymethod = 'YY' WHERE idpay = 1479;

  DELETE FROM dd.payment WHERE idpay = 1479;

   
select * from dd.Payment where idpay > (SELECT MAX(idpay) - 10 FROM dd.Payment)

select * from dd.paytrack

go

 

 
