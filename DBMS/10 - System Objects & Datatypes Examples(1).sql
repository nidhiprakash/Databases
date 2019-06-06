--USE CSE581;
USE Northwind;

SELECT *
FROM INFORMATION_SCHEMA.TABLES;

SELECT *
FROM INFORMATION_SCHEMA.ROUTINES;

--String Function
--Wrong
--SELECT STR(OrderDate) OrderDate
--FROM Orders
--WHERE OrderDate BETWEEN '1997-01-01' AND '1997-08-31'
--ORDER BY OrderDate DESC;

--Right
SELECT Convert(Date, OrderDate) OrderDateConverted, 
OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-08-31'--'01-JAN-1998' (Oracle)
ORDER BY OrderDate DESC;

SELECT STR(Freight,6,1) Freight, STR(Freight,5,2) Freight2
FROM Orders
ORDER BY OrderDate DESC;

SELECT *
FROM Categories;

SELECT replace(b.CategoryName, 'Beverage','Drink')
FROM Categories b;

--Date & Time Function
--Expected delivery date is 30 days from the ship date
--Method1
SELECT Convert(Date, ShippedDate+30) DeliverDate, 
ShippedDate ShippedDate
FROM Orders
WHERE ShippedDate IS NOT NULL;

--Method2
SELECT Dateadd(day,30,ShippedDate) DeliverDate, 
ShippedDate ShippedDate
FROM Orders
WHERE ShippedDate IS NOT NULL;

--How many days does it take to be shipped
SELECT AVG (DATEDIFF(dd, OrderDate, ShippedDate))
FROM Orders;

--All orders placed in January 1, 1998
SELECT *
FROM Orders
WHERE Year(OrderDate) = 1998 
AND Month(OrderDate) = '1'
AND Day(OrderDate) = 1;

--Math Functions
SELECT ABS(-198.6);
SELECT ROUND(-198.666666,2,6);
SELECT RAND();
SELECT SQUARE(2);
SELECT FLOOR(-198.6666);
SELECT FLOOR(-198.222);
SELECT FLOOR(198.6666);
SELECT FLOOR(198.222);
SELECT FLOOR(-198.6666);
--SELECT TO_CHAR(-198.222);--Oracle

USE CSE581LABS;
--Data Types
CREATE TABLE testDateAndMoney
(TestDate DATE,
 TestMoney MONEY);

INSERT INTO testDateAndMoney VALUES ('2014-11-18', 123456789.123);
INSERT INTO testDateAndMoney VALUES ('01-JAN-2014', 1234567890.1685);

SELECT * FROM testDateAndMoney;