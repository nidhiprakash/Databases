GRANT EXECUTE ON SCHEMA::[nsuryapr] TO Graders;
GRANT SELECT ON SCHEMA::[nsuryapr] TO Graders;
-----------------------Function-------------------------------------------------------------------
CREATE FUNCTION genderCount(@gender VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @countGender AS INT
SELECT @countGender = (SELECT COUNT(P.Gender_ID) FROM Person_Info P
WHERE exists (select * from Gender G WHERE P.Gender_ID = G.Gender_ID AND G.gender = @gender ))
RETURN @countGender
END;

SELECT nsuryapr.genderCount('Female') as count_of_females;

SELECT * FROM Person_Info 
SELECT * FROM Gender

-------------------------View---------------------------------------------------------------------
CREATE VIEW Benefits_view
AS
SELECT a.FirstName + ' ' + a.LastName as Employee_Name,b.Employee_ID, 
c.benefit_type as benefit_type ,d.CoverType_plan as cover_type ,f.Employee_PA ,f.Employer_PA
FROM
Person_Info a INNER JOIN Employee_Benefits b ON b.Employee_ID = a.Person_ID
INNER JOIN Benefits f ON b.Insurance_ID = f.Insurance_ID 
INNER JOIN InsuranceType c ON f.Insurance_for_ID = c.Insurance_for_ID
INNER JOIN CoverType d ON f.Cover_type_ID = d.Cover_type_ID

SELECT * FROM Benefits_view

SELECT * FROM Person_Info 
SELECT * FROM Benefits
SELECT * FROM Employee_Benefits
SELECT * FROM InsuranceType
SELECT * FROM CoverType 

---------------- Stored procedure to use cursor ---------------------------------------------
CREATE PROCEDURE AvgGrades_cursor2(@studentID as int, @average as DECIMAL(5,2) OUT) 
AS
BEGIN
DECLARE @aG DECIMAL(10,2),@finalGrade int = 0, @c float=0.0, @grades int
DECLARE avgCursor CURSOR FOR
SELECT final_marks FROM nsuryapr.CourseEnrollment WHERE Student_ID = @studentID AND
final_marks is not NULL
OPEN avgCursor
FETCH NEXT FROM avgCursor INTO @grades
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT @c = @c + 1
SELECT @finalGrade = @finalGrade + @grades
FETCH NEXT FROM avgCursor INTO @grades
END
SELECT @aG = ROUND(@finalGrade / @c,2)
CLOSE avgCursor
DEALLOCATE avgCursor
SELECT @average = @aG
END

DECLARE @avg as DECIMAL(5,2)
EXEC AvgGrades_cursor2 2, @avg out 
SELECT @avg [Average of the student]

SELECT * FROM CourseEnrollment

---------extra ----------------------------------------------------
SELECT * from CourseEnrollment

update CourseEnrollment 
set final_marks = 91 
where Student_ID = 9;


ALTER TABLE CourseEnrollment
DROP COLUMN final_numberGrade;

ALTER TABLE CourseEnrollment
ADD final_marks INT;

INSERT into CourseEnrollment VALUES
(2,2,1,'A-','A-',89),
(3,3,1,'A+','A-',90),
(6,4,1,'B-','B+',85)


---------------Stored Procedure to update and perform validation -----------------------------

CREATE PROCEDURE updateProc(@ID INT,@password VARCHAR(50),@cellphone VARCHAR(20), @email VARCHAR(50))
AS
DECLARE @valid1 INT
SELECT @valid1 = (SELECT LEN(@password))
IF(@valid1>5) 
BEGIN
UPDATE Person_Info
SET password = @password WHERE Person_ID = @ID
END
ELSE
BEGIN
PRINT 'Enter a valid password of length greater than 5'
END

IF ISNUMERIC(@cellphone) = 1
BEGIN
UPDATE Person_Info
SET Cell_phone = @cellphone WHERE Person_ID = @ID
END
ELSE
BEGIN
PRINT 'Invalid phone number provided'
END

IF (SELECT 1 from Person_Info WHERE Email_address = @email) IS NULL
BEGIN
UPDATE Person_Info
SET Email_address = @email WHERE Person_ID =@ID
END
ELSE
BEGIN
PRINT ' EMAIL ID already exists'
END

EXEC updateProc 5,'syracuse',3156678942,'msheth@syr.edu'
EXEC updateProc 8,'aksh','3xbxhhxhxh','akjagtap123@syr.edu'

SELECT * FROM Person_Info */


---------------Stored Procedure to delete  -------

CREATE PROCEDURE deleteCourse(@emp INT)
AS
DECLARE @Coursetaught INT
SELECT @Coursetaught = (SELECT CRN FROM EmployeeAndCourse WHERE Employee_ID = @emp)
DELETE FROM EmployeeAndCourse WHERE CRN = @Coursetaught
DELETE FROM CourseEnrollment WHERE CRN = @Coursetaught
DELETE FROM Course_schedule WHERE CRN = @Coursetaught
DELETE FROM JobOfEmployee WHERE Employee_ID = @emp
DELETE FROM Employee_Benefits WHERE Employee_ID = @emp
DELETE FROM Employee WHERE Employee_ID = @emp

EXEC deleteCourse 16

SELECT * FROM EmployeeAndCourse
SELECT * FROM CourseEnrollment
SELECT * FROM Course_schedule
SELECT * FROM JobOfEmployee
SELECT * FROM Employee_Benefits
SELECT * FROM Employee

---------Bonus Stored Proc ------------------

CREATE PROCEDURE CourseInfoToAttend (@crn INT)
AS
SELECT p.FirstName + ' ' + p.LastName as Professor,b.Building_name,c.Class_number,ct.StartTime,ct.EndTime
FROM EmployeeAndCourse es INNER JOIN Course_schedule cs ON es.CRN = cs.CRN
INNER JOIN Person_Info p ON es.Employee_ID = p.Person_ID 
INNER JOIN Classroom c ON cs.Classroom_ID = c.Classroom_ID
INNER JOIN Buildings b ON b.Building_ID = c.Building_ID
INNER JOIN CourseTimings ct ON ct.Timings_ID = cs.Timings_ID

EXEC CourseInfoToAttend 1















