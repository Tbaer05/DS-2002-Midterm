# DS2002 Midterm Project

## Overview

This project demonstrates a full ETL (Extract, Transform, Load) pipeline integrating data from multiple sources, transforming it, and loading it into a centralized data warehouse (`sales_mart`). Analytical SQL queries are then executed to provide insights into sales performance.

## Project Structure

```
DS-2002-Midterm/
├── ETL_notebook.ipynb      # Jupyter Notebook with the ETL pipeline
├── customers.csv           # Customer dimension source
├── products.csv            # Product dimension source
├── products.json           # Converted product JSON file
├── SQL_queries.sql         # Analytical SQL queries
├── README.md               # Project documentation
```

## Data Sources

1. **CSV Files**

   * `customers.csv`: Customer data extracted from AdventureWorks.
   * `products.csv`: Product data extracted from AdventureWorks, converted to `products.json` for JSON ingestion.
2. **MySQL Database**

   * Source: `AdventureWorks` database
   * Fact and dimension tables: `SalesOrderHeader`, `SalesOrderDetail`
3. **Optional NoSQL**

   * MongoDB can be used as an alternative dimension store (configured in ETL notebook).

## ETL Pipeline

The ETL pipeline is implemented in Python (Jupyter Notebook) with `pandas` and `SQLAlchemy`.

### Steps:

1. **Extract**

   * Load `customers.csv` and `products.json`.
   * Query `AdventureWorks` MySQL database for sales data (`SalesOrderHeader` + `SalesOrderDetail`).
2. **Transform**

   * Compute total sales per line item.
   * Build `DimDate` table from unique order dates.
   * Clean and organize dimension tables: `DimCustomer`, `DimProduct`.
3. **Load**

   * Load data into `sales_mart` MySQL database:

     * `DimDate`, `DimCustomer`, `DimProduct`, `FactSales`.

> 🔑 Note: MongoDB connection is optional; credentials are highlighted in the notebook for personal configuration.

## SQL Queries

1. **Total Sales by Customer**

```sql
SELECT 
    c.CustomerID, 
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSales DESC
LIMIT 1000;
```

2. **Total Sales by Product**

```sql
SELECT 
    p.ProductID, 
    p.Name AS ProductName, 
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimProduct p ON f.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalSales DESC
LIMIT 1000;
```

3. **Total Sales by Date**

```sql
SELECT 
    d.FullDate, 
    SUM(f.TotalAmount) AS TotalSales
FROM FactSales f
JOIN DimDate d ON DATE(f.OrderDate) = d.FullDate
GROUP BY d.FullDate
ORDER BY d.FullDate;
```

## How to Run

1. Clone the repository:

```bash
git clone https://github.com/<YOUR_USERNAME>/DS-2002-Midterm.git
cd DS-2002-Midterm
```

2. Install dependencies:

```bash
pip install pandas sqlalchemy pymysql pymongo
```

3. Update connection info:

   * MySQL: `user`, `password`, `host`
   * MongoDB: connection URI in the notebook

4. Run the ETL notebook:

   * Execute all cells to extract, transform, and load data into `sales_mart`.

5. Run the SQL queries in MySQL Workbench or any SQL client connected to `sales_mart`.

## Submission Instructions

1. Include **ETL Notebook** (`ETL_notebook.ipynb`) and **data files** (`customers.csv`, `products.csv`, `products.json`).
2. Include **SQL Queries** (`SQL_queries.sql`).
3. Upload all files to your GitHub repository: `DS-2002-Midterm`.

## Author
Tesher Baer

**Your Name:** `<Your Name>`
**GitHub:** [https://github.com/<YOUR_USERNAME>](https://github.com/<YOUR_USERNAME>)
