CREATE DATABASE Transactions_db;

CREATE TABLE Students
([S_ID] [int] NULL,[Name] [varchar](50) NULL,[Tuition_Fee] [decimal](18, 2) NULL,[Balance] [decimal](18, 2) NULL);

CREATE TABLE Payments
([P_ID] [int] IDENTITY(1,1) PRIMARY KEY,[Date] [date] NULL, [Amount] [decimal](18, 2) NULL,[S_ID] [int] NULL);

INSERT Payments ([Date], [Amount], [S_ID]) 
VALUES (CAST(N'2020-07-20' AS Date), CAST(23000.00 AS Decimal(18, 2)), 10);

INSERT Students ([S_ID], [Name], [Tuition_Fee], [Balance])
VALUES (10, N'Abaddon', CAST(23000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)));
INSERT Students ([S_ID], [Name], [Tuition_Fee], [Balance]) 
VALUES (20, N'Medusa', CAST(25000.00 AS Decimal(18, 2)), CAST(13000.00 AS Decimal(18, 2)));
INSERT Students ([S_ID], [Name], [Tuition_Fee], [Balance])
VALUES (50, N'Slark', CAST(18000.00 AS Decimal(18, 2)), CAST(18000.00 AS Decimal(18, 2)));
INSERT Students ([S_ID], [Name], [Tuition_Fee], [Balance]) 
VALUES (70, N'Leshrac', CAST(29000.00 AS Decimal(18, 2)), CAST(26000.00 AS Decimal(18, 2)));
INSERT Students ([S_ID], [Name], [Tuition_Fee], [Balance]) 
VALUES (90, N'Lina', CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)));

BEGIN TRANSACTION;

INSERT INTO Payments (Date, Amount, S_ID)
VALUES (CAST(N'2020-07-21' AS Date), CAST(1000.00 AS Decimal(18, 2)), 20);

UPDATE Students
SET Balance = Balance - 1000.00
WHERE S_ID = 20;

INSERT INTO Payments (Date, Amount, S_ID)
VALUES (CAST(N'2020-07-21' AS Date), CAST(1000.00 AS Decimal(18, 2)), 70);

UPDATE Students
SET Balance = Balance - 1000.00
WHERE S_ID = 70;

COMMIT;

SELECT * FROM Payments;
BEGIN TRANSACTION;

UPDATE Students
SET Balance = 15000.00
WHERE S_ID = 90;

INSERT INTO Payments (Date, Amount, S_ID)
VALUES (CAST(N'2020-07-28' AS Date), CAST(15000.00 AS Decimal(18, 2)), 90);

UPDATE Students
SET Tuition_Fee = Tuition_Fee - 0, Balance = Balance - 15000
WHERE S_ID = 90;

COMMIT;

BEGIN TRANSACTION;

DECLARE @PaymentAmount DECIMAL(18, 2);
SET @PaymentAmount = 15000.00;

UPDATE Students
SET Balance = Balance - @PaymentAmount
WHERE S_ID = 20; -- Medusa's S_ID

IF @PaymentAmount > 12000.00
BEGIN

    PRINT 'The transaction could not proceed, the payment that have been received was overpaid. Please try again. ' 
          + 'Your tuition balance: 12000.00 | Your payment: ' + CONVERT(VARCHAR, @PaymentAmount);
    
    ROLLBACK;
END
ELSE
BEGIN
    COMMIT;
END;

SELECT * FROM Payments;

BEGIN TRANSACTION;

UPDATE Students
SET Tuition_Fee = Tuition_Fee * 0.85 
WHERE S_ID = 50; 

INSERT INTO Payments (Date, Amount, S_ID)
VALUES (CAST(N'2020-08-05' AS Date), (SELECT Tuition_Fee FROM Students WHERE S_ID = 50), 50);

UPDATE Students
SET Balance = 0.00
WHERE S_ID = 50;

COMMIT;
	
	SELECT * FROM Payments;
