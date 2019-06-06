select * from nsuryapr.CourseEnrollment
select * from nsuryapr.Courses

Insert into nsuryapr.CourseEnrollment(StudentId ,CourseId) 
Select NTID,courseId from nsuryapr.users,nsuryapr.Courses where NTID = '01-HJPotter' AND CourseId = 4

Delete from nsuryapr.CourseEnrollment where StudentId = '01-HJPotter' AND CourseId = 4

