/*CREATE TRIGGER courseTriggers1 ON nsuryapr.CourseEnrollment
AFTER INSERT
AS
SET NOCOUNT ON;
BEGIN
UPDATE nsuryapr.Courses
SET OpenSeats = OpenSeats - (select count(*) from inserted where inserted.CourseId = nsuryapr.Courses.CourseId)
WHERE Courses.CourseId in (select CourseId from inserted)
END;*/


/*CREATE TRIGGER courseTiggers2 ON nsuryapr.CourseEnrollment
AFTER DELETE
AS
SET NOCOUNT ON;
BEGIN
UPDATE nsuryapr.Courses
SET OpenSeats = OpenSeats + (select count(*) from deleted where deleted.CourseId = Courses.CourseId)
WHERE Courses.CourseId in (select CourseId from deleted)
END;*/


CREATE TRIGGER courseTiggers3 ON nsuryapr.CourseEnrollment
AFTER UPDATE 
AS
IF UPDATE(CourseId)
BEGIN

UPDATE nsuryapr.Courses
SET Courses.OpenSeats = Courses.OpenSeats + (Select COUNT(*) from deleted 
where deleted.CourseId = Courses.CourseId)
WHERE Courses.CourseId in (select CourseId from deleted)


UPDATE nsuryapr.Courses
SET OpenSeats = OpenSeats - (select count(*) from inserted 
where inserted.CourseId = nsuryapr.Courses.CourseId)
WHERE Courses.CourseId in (select CourseId from inserted)

END;



