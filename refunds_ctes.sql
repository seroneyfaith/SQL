---query to detect suspicious refunds
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Refunds (
    RefundID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    RefundAmount DECIMAL(10,2),
    RefundDate DATE
);

---insert data
INSERT INTO Customers (CustomerID, CustomerName)
VALUES 
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Dana'),
(5, 'Eli');

-- Alice - Refunds in Jan, Feb, Mar, Apr, May (Suspicious!)
INSERT INTO Refunds (CustomerID, RefundAmount, RefundDate)
VALUES 
(1, 25.99, '2024-01-10'),
(1, 30.00, '2024-02-05'),
(1, 22.50, '2024-03-12'),
(1, 40.75, '2024-04-20'),
(1, 18.00, '2024-05-01');

-- Bob - Refunds in Jan, Feb (Not suspicious)
INSERT INTO Refunds (CustomerID, RefundAmount, RefundDate)
VALUES 
(2, 15.00, '2024-01-15'),
(2, 10.00, '2024-02-18');

-- Charlie - Refunds in 4 different months (Suspicious)
INSERT INTO Refunds (CustomerID, RefundAmount, RefundDate)
VALUES 
(3, 45.00, '2024-02-10'),
(3, 50.00, '2024-04-05'),
(3, 35.00, '2024-07-11'),
(3, 60.00, '2024-10-02');

-- Dana - Refunds in 1 month only
INSERT INTO Refunds (CustomerID, RefundAmount, RefundDate)
VALUES 
(4, 5.00, '2024-06-07');

-- Eli - Refunds across 5 months (Suspicious)
INSERT INTO Refunds (CustomerID, RefundAmount, RefundDate)
VALUES 
(5, 100.00, '2024-01-01'),
(5, 80.00, '2024-02-02'),
(5, 70.00, '2024-03-03'),
(5, 60.00, '2024-06-06'),
(5, 90.00, '2024-09-09');

---check the data using select
select * from Customers
select * from Refunds

---use a CTE to find the customers that are misusing the refund policy
WITH cust_refunds AS (
		select customerid,
		FORMAT(refunddate, 'yyyy-MM') as refundmonth
		from Refunds
		group by CustomerID, FORMAT(refunddate, 'yyyy-MM')
)
select c.CustomerID, c.CustomerName, count(cr.refundmonth) as refundmonths
from cust_refunds cr
join Customers c
on cr.CustomerID = c.CustomerID
group by c.CustomerID, c.CustomerName
having COUNT(cr.refundmonth) >=4

---put this cte in a view:
create view v_customer_refunds
as
WITH cust_refunds AS (
		select customerid,
		FORMAT(refunddate, 'yyyy-MM') as refundmonth
		from Refunds
		group by CustomerID, FORMAT(refunddate, 'yyyy-MM')
)
select c.CustomerID, c.CustomerName, count(cr.refundmonth) as refundmonths
from cust_refunds cr
join Customers c
on cr.CustomerID = c.CustomerID
group by c.CustomerID, c.CustomerName
having COUNT(cr.refundmonth) >=4

select * from v_customer_refunds

---use in a stored procedure
create procedure cust_refunds
as
begin
	set nocount on; ---ensures that there's no 'rows affected' msg

	WITH cust_refunds AS (
		select customerid,
		FORMAT(refunddate, 'yyyy-MM') as refundmonth
		from Refunds
		group by CustomerID, FORMAT(refunddate, 'yyyy-MM')
)
select c.CustomerID, c.CustomerName, count(cr.refundmonth) as refundmonths
from cust_refunds cr
join Customers c
on cr.CustomerID = c.CustomerID
group by c.CustomerID, c.CustomerName
having COUNT(cr.refundmonth) >=4

end

exec cust_refunds