ALTER PROCEDURE nsuryapr.DivideErrorHandling (
								  @A AS INT, 
								  @B  AS INT
								 ) 
AS
	    DECLARE @OutPrint VARCHAR(MAX);
        DECLARE @Result INT;

		IF IsNumeric(@A) = 0 AND IsNumeric(@B) = 0
		BEGIN 
			RAISERROR('An error has occurred', 16, -1) 
			RETURN -1
		END;

		SET @Result = @A / @B 
				
    SET @OutPrint='Successful';
	PRINT @OutPrint;
    PRINT @Result;

;

EXEC nsuryapr.DivideErrorHandling a,b
EXEC nsuryapr.DivideErrorHandling 6,3