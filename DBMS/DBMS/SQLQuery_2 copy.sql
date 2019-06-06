select * from nsuryapr.CourseEnrollment
select * from nsuryapr.Courses



Insert into nsuryapr.CourseEnrollment(StudentId ,CourseId,FinalGrade) 
VALUES ('03-HJGranger',7,null),('02-RBWeasley',2,null),('01-HJPotter',7,null);

Delete from nsuryapr.CourseEnrollment where EnrollmentId > 12

Update nsuryapr.CourseEnrollment
set CourseId=3
WHERE EnrollmentId in (1,3)
