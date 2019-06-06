USE CSE581labs;

CREATE TABLE Shippers(
						ShipperID     INT, 
						CompanyName   NVARCHAR(40), 
						Phone         INT
						);

--Raise an Error
CREATE PROCEDURE nsuryapr.TestErrorHandling (
								  @ShipperID AS INT, 
								  @CompanyName  AS NVARCHAR(40), 
								  @Phone  AS VARCHAR(10)
								 ) 
AS
	    DECLARE @OutPrint VARCHAR(MAX);

		IF IsNumeric(@Phone) =0
		BEGIN 
			RAISERROR('Passed value for @Phone should be digital', 16, -1) 
			RETURN -1
		END;

		INSERT INTO Shippers VALUES (@ShipperID, 
								  @CompanyName, 
								  @Phone);
				
    SET @OutPrint='Successfully inserted';
	PRINT @OutPrint;
;

--Try and Catch
CREATE PROCEDURE nsuryapr.TestErrorHandling2 (
								  @ShipperID AS INT, 
								  @CompanyName  AS NVARCHAR(40), 
								  @Phone  AS VARCHAR(10)
								 ) 
AS
	    DECLARE @OutPrint VARCHAR(MAX);


		BEGIN TRY 
		INSERT INTO Shippers VALUES (@ShipperID, 
								  @CompanyName, 
								  @Phone);
		END TRY

		BEGIN CATCH 			
	        SET @OutPrint='An error has occurred for Shipper '+ CONVERT(VARCHAR,@ShipperID);		
			PRINT @OutPrint;
			--ROLLBACK TRAN;
			RETURN;
		END CATCH;
				
	PRINT @OutPrint;
;

--Check for errors: not work, @@ERROR only catches system errors
ALTER PROCEDURE nsuryapr.TestErrorHandling3 (
								  @ShipperID AS INT, 
								  @CompanyName  AS NVARCHAR(40), 
								  @Phone  AS VARCHAR(10)
								 ) 
AS
	    DECLARE @OutPrint VARCHAR(MAX);

		INSERT INTO Shippers VALUES (@ShipperID, 
								  @CompanyName, 
								  @Phone);

		IF @@ERROR <> 0
	        BEGIN
		    ROLLBACK TRAN;
	        SET @OutPrint='An error has occurred'
			PRINT @OutPrint;
			RETURN;
		    END		

		PRINT @OutPrint;
;

SELECT IsNumeric('a');
SELECT IsNumeric(10);
SELECT IsNumeric('10');

DELETE Shippers;

SELECT * FROM Shippers;

EXEC nsuryapr.TestErrorHandling3 1,'Company 1','dfg';
EXEC nsuryapr.TestErrorHandling2 1,'Company 1','dfg';
EXEC nsuryapr.TestErrorHandling3 1,'Company 1','123';
EXEC nsuryapr.TestErrorHandling2 1,'Company 1','123';



EXEC nsuryapr.TestErrorHandling 1,'Company 1','fghf';
EXEC nsuryapr.TestErrorHandling 2,'Company 2','123456789';
EXEC nsuryapr.TestErrorHandling 3,'Company 3',1234567890;
