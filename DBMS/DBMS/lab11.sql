create procedure nsuryapr.checkCourseEnrollment (@courseID as integer, @studentID as varchar(20), 
@message as varchar(256) out) as
declare @enrollmentID integer
select @enrollmentID = (select EnrollmentId from nsuryapr.CourseEnrollment
where StudentId = @studentID and CourseId = @courseID);
if(@enrollmentID is not null)
		begin
		select @message = 'Student already enrolled'
		end
else
		begin 
		declare @faculty varchar(20)
select @faculty = (select Faculty from nsuryapr.Courses where CourseId = @courseID);
		if (@faculty is null or @faculty = '')
			begin
			select @message = 'enroll only after faculty has been selected'
			end
		else 
			begin
			declare @openSeats integer
select @openseats = (select Openseats from nsuryapr.Courses where CourseId = @courseID);
			if(@openSeats > 0)
				begin
insert into nsuryapr.CourseEnrollment (StudentID, CourseId) values (@studentID, @courseID);
				select @message = 'Enrolled'
				select @openSeats = @openSeats -1
update nsuryapr.Courses set OpenSeats = @openSeats where CourseId = @courseID;
				end
			else
				begin
select @message = 'Seats not available'
				end
			end
		end





declare @outputmessage as varchar(256);
Exec nsuryapr.checkCourseEnrollment @courseID = 1,@studentID = '03-HJGranger',
@message = @outputmessage out;
print @outputmessage;


declare @outputmessage1 as varchar(256);
Exec nsuryapr.checkCourseEnrollment @courseID = 7,@studentID = '01-HJPotter',
@message = @outputmessage1 out;
print @outputmessage1;

SELECT * from nsuryapr.CourseEnrollment

SELECT * from nsuryapr.Courses

declare @outputmessage3 as varchar(256);
Exec nsuryapr.checkCourseEnrollment @courseID = 2,@studentID = '03-HJGranger',
@message = @outputmessage3 out;
print @outputmessage3;

SELECT * from nsuryapr.CourseEnrollment

SELECT * from nsuryapr.Courses

declare @outputmessage2 as varchar(256);
Exec nsuryapr.checkCourseEnrollment @courseID = 5,@studentID = '03-HJGranger',
@message = @outputmessage2 out;
print @outputmessage2;



