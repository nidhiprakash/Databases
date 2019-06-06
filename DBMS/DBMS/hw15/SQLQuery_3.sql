CREATE PROCEDURE nsuryapr.DivideErrorCheck (
								  @A AS INT, 
								  @B  AS INT
								 ) 
AS
	    DECLARE @OutPrint VARCHAR(MAX);
        DECLARE @Result INT;


		BEGIN TRY 
           SELECT @Result = @A / @B
		END TRY

		BEGIN CATCH 
            SELECT @Result = -1			
	        SET @OutPrint='An error has occurred, Try Again';
			PRINT @OutPrint;
            PRINT @Result;
			--ROLLBACK TRAN;
			RETURN;
		END CATCH;
				
	PRINT @OutPrint;
    PRINT @Result;
;

EXEC nsuryapr.DivideErrorCheck 10,2





EXEC nsuryapr.DivideErrorCheck 10,0

