CREATE FUNCTION calcAvgGrade(@studentID as varchar(50)) RETURNS DECIMAL(10,2) AS
BEGIN
DECLARE @aG DECIMAL(10,2),@finalGrade int = 0, @c float=0.0, @grades int
DECLARE avgGradesCursor CURSOR FOR
SELECT FinalGrade FROM nsuryapr.CourseEnrollment WHERE StudentId = @studentID AND 
FinalGrade is not NULL

OPEN avgGradesCursor
FETCH NEXT FROM avgGradesCursor INTO @grades

	WHILE @@FETCH_STATUS = 0
	BEGIN
	     SELECT @c = @c + 1
         SELECT @finalGrade = @finalGrade + @grades
	     FETCH NEXT FROM avgGradesCursor INTO @grades
	END

SELECT @aG = ROUND(@finalGrade / @c,2)

CLOSE avgGradesCursor
DEALLOCATE avgGradesCursor
RETURN @aG
END

SELECT * FROM nsuryapr.CourseEnrollment

SELECT nsuryapr.calcAvgGrade('03-HJGranger') as Avg_Grade