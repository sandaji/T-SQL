create database Test_Tables;
go
use [Trigger_Tables];
go
CREATE SCHEMA TEST AUTHORIZATION dbo;
GO
drop TABLE if exists test.Donor;
CREATE TABLE test.Donor (
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

drop TABLE if exists test.Project;
CREATE TABLE test.Project (
                   idProj int,
                   Projname nvarchar(60),
                   Projstartdate DATE,
                   Projenddate DATE,
                   Projfundgoal decimal(12,2),
                   ProjCoord nvarchar(20),
                   CONSTRAINT project_id_pk PRIMARY KEY(idProj),
                   CONSTRAINT project_name_uk  UNIQUE (Projname)  );
				   
drop TABLE if exists test.Status;
CREATE TABLE test.Status (
                   idStatus int,
                   Statusdesc nvarchar(15),
                   CONSTRAINT status_id_pk PRIMARY KEY(idStatus) );  
				   
drop TABLE if exists test.Pledge;
CREATE TABLE test.Pledge (
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
                           REFERENCES test.donor (idDonor), 
                   CONSTRAINT pledge_idProj_fk FOREIGN KEY (idProj)
                           REFERENCES test.project (idProj),
                   CONSTRAINT pledge_idStatus_fk FOREIGN KEY (idStatus)
                           REFERENCES test.status (idStatus));   
						   
drop TABLE if exists test.Payment;
CREATE TABLE test.Payment (
                   idPay int,
                   idPledge int,
                   Payamt decimal(8,2),
                   Paydate DATE,
                   Paymethod char(2),
                   CONSTRAINT payment_id_pk PRIMARY KEY(idPay),
                   CONSTRAINT pay_idpledge_fk FOREIGN KEY (idPledge)
                           REFERENCES test.pledge (idPledge) );                   
INSERT INTO test.donor  
  VALUES (301, 'Mary', 'Treanor', 'I','243 main St.', 'Norfolk', 'VA','23510',NULL,NULL,'mtrea492@mdv.com','Y','01-SEP-2012');
INSERT INTO test.donor  
  VALUES (302, 'Patrick', 'Lee', 'I','11 Hooper St.', 'Norfolk', 'VA','23510','7572115445',NULL,'pleeNorf@gmail.com','N','09-SEP-2012');
INSERT INTO test.donor   
  VALUES (303, 'Terry', 'Venor', 'I','556 Loop Lane.', 'Chesapeake', 'VA','23320',NULL,NULL,'tervenr@drw.edu','Y','18-SEP-2012');
INSERT INTO test.donor  
  VALUES (304, 'Sherry', 'Pane', 'I','Center Blvd.', 'Virginia Beach', 'VA','23455',NULL,NULL,'toppane@yahoo.com','Y','21-SEP-2012');
INSERT INTO test.donor   
  VALUES (305, 'Thomas', 'Sheer', 'I','66 Train St.', 'Chesapeake', 'VA','23322','7579390022',NULL,'tls3488@sheer.com','Y','01-MAR-2013');
INSERT INTO test.donor   
  VALUES (306, NULL, 'Coastal Developers', 'B','3667 Shore Dr.', 'Virginia Beach', 'VA','23450','8889220004',NULL,'coastVA@cdev.com','Y','30-SEP-2012');
INSERT INTO test.donor   
  VALUES (307, NULL, 'VA Community Org', 'G','689 Bush Dr.', 'Norfolk', 'VA','23513','7578337467','7578337468','vacmorg@biz.com','Y','03-OCT-2012');
INSERT INTO test.donor   
  VALUES (308, 'Betty', 'Konklin', 'I','11 Shark Ln.', 'Virginia Beach', 'VA','23455','7574550087',NULL,'shark11@cox.net','N','04-OCT-2012');
INSERT INTO test.donor   
  VALUES (309, 'Jim', 'Tapp', 'I','200 Pine Tree Blvd.', 'Chesapeake', 'VA','23320','',NULL,'','N','08-OCT-2012');
INSERT INTO test.donor   
  VALUES (310, NULL, 'Unique Dezigns', 'B','Connect Circle Unit 12', 'Chesapeake', 'VA','23320','7574442121',NULL,'UDezigns@cox.net','Y','11-SEP-2012');
INSERT INTO test.project
  VALUES (500,'Elders Assistance League', '01-SEP-2012','31-OCT-2012',15000,'Shawn Hasee');
INSERT INTO test.project
  VALUES (501,'Community food pantry #21 freezer equipment', '01-OCT-2012','31-DEC-2012',65000,'Shawn Hasee');
INSERT INTO test.project
  VALUES (502,'Lang Scholarship Fund', '01-JAN-2013','01-NOV-2013',100000,'Traci Brown');
INSERT INTO test.project
  VALUES (503,'Animal shelter Vet Connect Program', '01-DEC-2012','30-MAR-2013',25000,'Traci Brown');
INSERT INTO test.project
  VALUES (504,'Shelter Share Project 2013', '01-FEB-2013','31-JUL-2013',35000,'Traci Brown');
INSERT INTO test.status
  VALUES (10,'Open');
INSERT INTO test.status
  VALUES (20,'Complete');
INSERT INTO test.status
  VALUES (30,'Overdue');
INSERT INTO test.status
  VALUES (40,'Closed');
INSERT INTO test.status
  VALUES (50,'Hold');
INSERT INTO test.pledge
   VALUES (100,303,'18-SEP-2012',80,500,20,NULL,0,738,'Y');
INSERT INTO test.pledge
   VALUES (101,304,'21-SEP-2012',35,500,20,NULL,0,738,'Y');
INSERT INTO test.pledge
   VALUES (102,310,'01-OCT-2012',500,501,20,NULL,0,749,'Y');
INSERT INTO test.pledge
   VALUES (103,307,'03-OCT-2012',2000,501,20,NULL,0,749,'N');
INSERT INTO test.pledge
   VALUES (104,308,'04-OCT-2012',240,501,10,NULL,12,749,'Y');
INSERT INTO test.pledge
   VALUES (105,309,'08-OCT-2012',120,501,10,NULL,12,749,'Y');
INSERT INTO test.pledge
   VALUES (106,301,'12-OCT-2012',75,500,20,NULL,0,738,'N');
INSERT INTO test.pledge
   VALUES (107,302,'15-OCT-2012',1200,501,10,NULL,24,749,'Y');
INSERT INTO test.pledge
   VALUES (108,308,'20-JAN-2013',480,503,10,NULL,24,790,'N');
INSERT INTO test.pledge
   VALUES (109,301,'01-FEB-2013',360,503,10,NULL,12,790,'N');
INSERT INTO test.pledge
   VALUES (110,303,'01-MAR-2013',300,504,10,NULL,12,756,'N');
INSERT INTO test.pledge
   VALUES (111,306,'01-MAR-2013',1500,504,20,NULL,0,756,'Y');
INSERT INTO test.pledge
   VALUES (112,309,'16-MAR-2013',240,504,10,NULL,12,756,'N');
INSERT INTO test.payment
   VALUES (1425,100,80,'18-SEP-2012','CC');
INSERT INTO test.payment
   VALUES (1426,101,35,'21-SEP-2012','DC');
INSERT INTO test.payment
   VALUES (1427,102,500,'01-OCT-2012','CH');
INSERT INTO test.payment
   VALUES (1428,103,2000,'03-OCT-2012','CH');
INSERT INTO test.payment
   VALUES (1429,106,75,'12-OCT-2012','CC');
INSERT INTO test.payment
   VALUES (1430,104,20,'01-NOV-2012','CC');
INSERT INTO test.payment
   VALUES (1431,105,10,'01-NOV-2012','CC');
INSERT INTO test.payment
   VALUES (1432,107,50,'01-NOV-2012','CC');
INSERT INTO test.payment
   VALUES (1433,104,20,'01-DEC-2012','CC');
INSERT INTO test.payment
   VALUES (1434,105,10,'01-DEC-2012','CC');
INSERT INTO test.payment
  VALUES (1435,107,50,'01-DEC-2012','CC');
INSERT INTO test.payment
   VALUES (1436,104,20,'01-JAN-2013','CC');
INSERT INTO test.payment
   VALUES (1437,105,10,'01-JAN-2013','CC');
INSERT INTO test.payment
   VALUES (1438,107,50,'01-JAN-2013','CC');
INSERT INTO test.payment
   VALUES (1439,104,20,'01-FEB-2013','CC');
INSERT INTO test.payment
   VALUES (1440,105,10,'01-FEB-2013','CC');
INSERT INTO test.payment
   VALUES (1441,107,50,'01-FEB-2013','CC');
INSERT INTO test.payment
   VALUES (1442,108,20,'01-FEB-2013','CC');
INSERT INTO test.payment
   VALUES (1443,109,30,'01-FEB-2013','CC');
INSERT INTO test.payment
   VALUES (1444,104,20,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1445,105,10,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1446,107,50,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1447,108,20,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1448,109,30,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1449,110,25,'01-MAR-2013','CC');
INSERT INTO test.payment
   VALUES (1450,111,1500,'01-MAR-2013','CH');
INSERT INTO test.payment
   VALUES (1451,104,20,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1452,105,10,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1453,107,50,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1454,108,20,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1455,109,30,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1456,110,25,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1457,112,20,'01-APR-2013','CC');
INSERT INTO test.payment
   VALUES (1458,104,20,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1459,105,10,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1460,107,50,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1461,108,20,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1462,109,30,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1463,110,25,'01-MAY-2013','CC');
INSERT INTO test.payment
   VALUES (1464,112,20,'01-MAY-2013','CC');

drop TABLE if exists test.paytrack;   
   CREATE TABLE test.paytrack
  (idtrack INT  NOT NULL  IDENTITY  PRIMARY KEY,
   ptuser VARCHAR(30),
   ptdate DATE,
   ptaction VARCHAR(60),
   ptpayid int);

   go
CREATE TRIGGER  InsertPayment   
ON test.Payment 
FOR INSERT  
AS  
BEGIN  
  Declare @Id int  
  SELECT @Id = idPay from inserted  
  INSERT INTO test.paytrack 
  VALUES ('New payment with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is added at ' + CAST(Getdate() AS VARCHAR(22)))  
END  

INSERT INTO test.payment  VALUES (1479,112,20,'01-JUN-2013','CC');
go

 select * from test.Payment where idpay > (SELECT MAX(idpay) - 10 FROM test.Payment)
select * from test.paytrack





