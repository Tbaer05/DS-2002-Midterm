SELECT * FROM Customer;
SELECT ProductID, Name, ListPrice FROM Product;
CREATE DATABASE IF NOT EXISTS sales_mart;

#SQL Queries after ETL creates sales_mart from AdventureWorks
#total sales by customer and product
SELECT 
    c.CustomerID,
    c.CustomerType,
    p.ProductID,
    p.Name AS ProductName,
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
JOIN DimProduct p ON f.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerType, p.ProductID, p.Name
ORDER BY TotalSales DESC
LIMIT 1000;

#total sales by date with customer info
SELECT 
    d.FullDate,
    c.CustomerID,
    c.CustomerType,
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
JOIN DimDate d ON DATE(f.OrderDate) = d.FullDate
GROUP BY d.FullDate, c.CustomerID, c.CustomerType
ORDER BY d.FullDate;

#total sales by product and date
SELECT 
    d.FullDate,
    p.ProductID,
    p.Name AS ProductName,
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimProduct p ON f.ProductID = p.ProductID
JOIN DimDate d ON DATE(f.OrderDate) = d.FullDate
GROUP BY d.FullDate, p.ProductID, p.Name
ORDER BY d.FullDate;

