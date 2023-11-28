CREATE DATABASE ConcurrencyControl;

USE ConcurrencyControl;

CREATE TABLE Accounts (
    A_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Balance DECIMAL(10, 2)
);
 INSERT INTO Accounts (A_ID, Name, Balance)
VALUES
    (1, 'Thor', 8000.00),
    (2, 'Hulk', 4000.00),
    (3, 'Thanos', 12000.00),
    (4, 'Loki', 3000.00),
    (5, 'Stark', 15000.00);

	SELECT * FROM Accounts;
	 
	CREATE TABLE Transac_History (
    T_ID INT,
    Date DATE,
    Amount DECIMAL(10, 2),
    A_ID INT,
    FOREIGN KEY (A_ID) REFERENCES Accounts (A_ID)
);

INSERT INTO Transac_History (T_ID, Date, Amount, A_ID)
VALUES
    (1, '2020-09-02', -1500.00, 3),
    (2, '2020-09-03', 3000.00, 5),
    (3, '2020-09-03', -3000.00, 1);
	

BEGIN TRANSACTION;
UPDATE Accounts
SET Balance = Balance - 500 
WHERE A_ID = 1
WAITFOR DELAY '00:00:001'
COMMIT

SELECT * FROM Accounts WHERE A_ID = 5

BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT Balance FROM Accounts WHERE A_ID = 5;
COMMIT TRANSACTION;
SELECT * FROM Accounts WHERE A_ID = 5

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
WAITFOR DELAY '00:00:01'
SELECT * FROM Accounts
COMMIT

BEGIN TRANSACTION
INSERT INTO Accounts (a_id, name, balance) VALUES
(6, 'Clint', 19000.00)
INSERT INTO Transac_History (t_id, date, amount, a_id) VALUES
(4, '2020-08-28', 19000.00, 6)

WAITFOR DELAY '00:00:01'
SELECT *FROM Accounts
COMMIT

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
UPDATE Accounts
SET Balance = Balance- 500
WHERE A_ID = 1
WAITFOR DELAY '00:00:01'
COMMIT
SELECT * FROM Accounts

BEGIN TRANSACTION 
UPDATE Accounts
SET Balance = Balance - 500 
WHERE A_ID = 1 
INSERT INTO Transac_History (t_id, date, amount, a_id) VALUES (3, '2020-08-28', -500.00, 1)
WAITFOR DELAY '00:00:01' 
SELECT *FROM Transac_History;
COMMIT

  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
INSERT INTO Accounts VALUES (7,'Natasha' , 9000.00);
SELECT *FROM Accounts
WAITFOR DELAY '00:00:001'
COMMIT

