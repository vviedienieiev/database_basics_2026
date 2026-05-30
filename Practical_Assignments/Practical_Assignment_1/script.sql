
-- Practical Assignment 01 "Complex select"

CREATE DATABASE PA01;

USE PA01;

-- Creating tables

CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    ClientName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert data into Clients
INSERT INTO Clients (ClientName, Email, Phone) VALUES
('John Doe', 'john.doe@example.com', '555-1234'),
('Jane Smith', 'jane.smith@example.com', '555-5678'),
('Alice Johnson', 'alice.johnson@example.com', '555-8765'),
('Bob Brown', 'bob.brown@example.com', '555-4321'),
('Charlie Black', 'charlie.black@example.com', '555-1122');

-- Insert data into Products
INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 999.99),
('Smartphone', 499.99),
('Tablet', 299.99),
('Smartwatch', 199.99),
('Headphones', 99.99);

-- Insert data into Orders
INSERT INTO Orders (ClientID, ProductID, OrderDate, Quantity) VALUES
(1, 1, '2024-09-01', 1),
(1, 3, '2024-09-01', 2),
(2, 2, '2024-08-31', 1),
(3, 4, '2024-08-30', 3),
(4, 1, '2024-08-29', 1),
(4, 5, '2024-08-29', 2),
(5, 3, '2024-08-28', 1),
(5, 4, '2024-08-28', 1),
(5, 2, '2024-08-28', 1),
(3, 1, '2024-08-30', 1);


/*
 * This query will return the total quantity of
 * each product ordered by each client
 * and the total amount spent by them on those products, sorted by the highest spenders first.
 */

SELECT
    c.ClientName,
    p.ProductName,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(o.Quantity * p.Price) AS TotalSpent
FROM
    Orders o
JOIN
    Clients c ON o.ClientID = c.ClientID
JOIN
    Products p ON o.ProductID = p.ProductID
WHERE
    o.OrderDate >= '2024-08-28'
GROUP BY
    c.ClientName, p.ProductName
ORDER BY
    TotalSpent DESC;
