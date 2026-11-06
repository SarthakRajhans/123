
CREATE DATABASE IF NOT EXISTS DataWarehouse;
USE DataWarehouse;

-- 1. Product Dimension
CREATE TABLE Dim_Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 2. Customer Dimension
CREATE TABLE Dim_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- 3. Time Dimension
CREATE TABLE Dim_Time (
    Time_ID INT PRIMARY KEY,
    Day INT,
    Month INT,
    Year INT
);

-- 4. Sales Fact Table
CREATE TABLE Fact_Sales (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Time_ID INT,
    Quantity INT,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Product_ID) REFERENCES Dim_Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Dim_Customer(Customer_ID),
    FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID)
);

-- 5. Insert Data
INSERT INTO Dim_Product VALUES
(1,'Laptop','Electronics',50000),
(2,'Mobile','Electronics',20000);

INSERT INTO Dim_Customer VALUES
(101,'Rahul','Mumbai','Maharashtra'),
(102,'Priya','Pune','Maharashtra');

INSERT INTO Dim_Time VALUES
(1,10,5,2024),
(2,15,5,2024);

INSERT INTO Fact_Sales VALUES
(1001,1,101,1,2,100000),
(1002,2,102,2,1,20000);

-- 6. Execute Analysis Query
SELECT
    C.Customer_Name,
    P.Product_Name,
    T.Month,
    F.Quantity,
    F.Total_Amount
FROM Fact_Sales F
JOIN Dim_Product P ON F.Product_ID = P.Product_ID
JOIN Dim_Customer C ON F.Customer_ID = C.Customer_ID
JOIN Dim_Time T ON F.Time_ID = T.Time_ID;

-- 7. Verify Tables
SHOW TABLES;
SELECT * FROM Fact_Sales;
