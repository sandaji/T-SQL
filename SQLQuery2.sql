 create database tc;
 DROP TABLE IF EXISTS dbo.Employees;

CREATE TABLE dbo.Employees
(
empid INT NOT NULL,
empname VARCHAR(25) NOT NULL,
mgrid INT NULL,
CONSTRAINT PK_Employees PRIMARY KEY(empid),
CONSTRAINT CHK_Employees_empid CHECK(empid > 0),
CONSTRAINT FK_Employees_Employees
FOREIGN KEY(mgrid) REFERENCES dbo.Employees(empid)
);


exec dbo.error_procedur @id = 1, @name ='Emp1', @manager = NULL;
use [tc];

go
	exec dbo.error_procedur @id = 0, @name = 'Emp1', @manager = NULL;
	use [tc];

go
  exec dbo.error_procedur @id = 'A', @name = 'Emp1', @manager = NULL;

exec dbo.error_procedur @id = null, @name = 'Emp1', @manager = NULL;

create FUNCTION checkError( @errornum INT ) RETURNS NVARCHAR(1000) AS 
BEGIN
 DECLARE @message NVARCHAR(1000) 
 
 IF @errorNUM = 2627 
 BEGIN SET 
 @message = 'Handling PK violation...' 
 END

 IF @errorNUM = 547 
 BEGIN SET
 @message = 'Handling CHECK/FK constraint violation...' 
 END

 IF @errorNUM = 515 
 BEGIN SET
 @message = 'Handling NULL violation...' 
 END

 IF @errorNUM = 245 
 BEGIN SET
 @message = 'Handling conversion error...' 
 END

 RETURN @message 
END
use [tc];

go
create procedure error_procedur as select * from tc.dbo.Employees;
go
ALTER PROCEDURE error_procedur (@id int, @name VARCHAR(25), @manager int) AS 
BEGIN  
 DECLARE @errorNUM int
 BEGIN TRY 
 INSERT INTO
 tc.dbo.Employees(empid, empname, mgrid) 
 VALUES
 (@id, @name, @manager)
 END TRY 
 BEGIN CATCH
 SELECT @errornum = ERROR_NUMBER() 
 DECLARE @showmessage NVARCHAR(MAX)
 DECLARE @Message varchar(MAX) = ERROR_MESSAGE()
 DECLARE @Severity int = ERROR_SEVERITY();
 DECLARE @State int = ERROR_STATE();
 
 
 SELECT
 @showmessage = tc.dbo.checkError (@errornum) PRINT @showmessage; RAISERROR 
(@message, @severity, @state); 
 END CATCH 
END