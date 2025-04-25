---create table sales
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT,
    SaleDate DATE
);

---populate table using insert 
INSERT INTO Sales (ProductName, Quantity, SaleDate)
VALUES 
-- January
('Headphones', 50, '2024-01-05'),
('Headphones', 60, '2024-01-15'),
('USB Cable', 30, '2024-01-10'),
('USB Cable', 40, '2024-01-20'),
('Charger', 20, '2024-01-25'),

-- February
('Headphones', 70, '2024-02-03'),
('USB Cable', 60, '2024-02-12'),
('Charger', 90, '2024-02-14'),
('USB Cable', 100, '2024-02-20'),
('Charger', 60, '2024-02-25'),

-- March
('Headphones', 80, '2024-03-01'),
('Headphones', 30, '2024-03-11'),
('USB Cable', 70, '2024-03-10'),
('Charger', 40, '2024-03-13'),
('USB Cable', 60, '2024-03-22'),

-- April
('Headphones', 95, '2024-04-05'),
('USB Cable', 85, '2024-04-10'),
('Charger', 55, '2024-04-18'),
('Charger', 45, '2024-04-22'),
('USB Cable', 30, '2024-04-30'),

-- May
('Headphones', 120, '2024-05-01'),
('USB Cable', 60, '2024-05-05'),
('Charger', 90, '2024-05-09'),
('USB Cable', 55, '2024-05-15'),
('Charger', 70, '2024-05-21'),

-- June
('Headphones', 75, '2024-06-03'),
('USB Cable', 65, '2024-06-10'),
('Charger', 80, '2024-06-15'),
('Headphones', 55, '2024-06-20'),
('USB Cable', 40, '2024-06-25'),

-- July
('Headphones', 45, '2024-07-02'),
('USB Cable', 100, '2024-07-08'),
('Charger', 75, '2024-07-14'),
('Headphones', 85, '2024-07-19'),
('USB Cable', 35, '2024-07-28'),

-- August
('Charger', 90, '2024-08-01'),
('USB Cable', 80, '2024-08-05'),
('Headphones', 100, '2024-08-09'),
('USB Cable', 55, '2024-08-16'),
('Charger', 60, '2024-08-21'),

-- September
('USB Cable', 120, '2024-09-02'),
('Charger', 100, '2024-09-10'),
('Headphones', 70, '2024-09-15'),
('USB Cable', 45, '2024-09-22'),
('Headphones', 65, '2024-09-30'),

-- October
('Charger', 85, '2024-10-05'),
('USB Cable', 95, '2024-10-10'),
('Headphones', 110, '2024-10-15'),
('USB Cable', 50, '2024-10-22'),
('Headphones', 40, '2024-10-30');

select * from Sales

---find the product that sold the most units in each month of the year
WITH MonthlySales AS (
	 SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        ProductName,
        SUM(Quantity) AS TotalSold
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM'), ProductName
),
RankedSales as(
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY SaleMonth ORDER BY TotalSold DESC) AS rn
    FROM MonthlySales
)
SELECT SaleMonth, ProductName, TotalSold
FROM RankedSales
WHERE rn = 1;



