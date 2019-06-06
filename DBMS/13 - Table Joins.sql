USE CSE581labs;

CREATE TABLE Parts
(partSN  VARCHAR(5),
 partDesc VARCHAR(10),
 cost DECIMAL);

CREATE TABLE Orders
(orderNum VARCHAR(10),
 partSN  VARCHAR(5), 
 quantity INTEGER);

 INSERT INTO Parts (partSN, partDesc, cost) VALUES 
  ('001','Part 1',20), ('002','Part 2',40),
  ('003','Part 3',60), ('004','Part 4',80);

 INSERT INTO Orders VALUES 
  ('1001','002',2), ('1002','003',1),
  ('1003','004',1), ('1004','005',2);

SELECT * FROM Orders;
SELECT * FROM Parts;

--SQL Server
--Inner Join
SELECT *
FROM Orders a, Parts b
WHERE a.partSN=b.partSN;

--or
SELECT *
FROM Orders a INNER JOIN Parts b
ON a.partSN=b.partSN;

--Right Outer Join
SELECT *
FROM Orders a RIGHT OUTER JOIN Parts b
ON a.partSN=b.partSN;

--Left Outer Join
SELECT *
FROM Orders a LEFT OUTER JOIN Parts b
ON a.partSN=b.partSN;

--Full Outer Join
SELECT *
FROM Orders a FULL OUTER JOIN Parts b
ON a.partSN=b.partSN;

--Oracle
--Inner Join
SELECT *
FROM Orders a, Parts b
WHERE a.partSN=b.partSN;

----Right Outer Join
--SELECT *
--FROM Orders a, Parts b
--WHERE a.partSN(+)=b.partSN;

----Left Outer Join
--SELECT *
--FROM Orders a, Parts b
--WHERE a.partSN=b.partSN(+);

----Full Outer Join: not allowed
--SELECT *
--FROM Orders a, Parts b
--WHERE a.partSN(+)=b.partSN(+);

