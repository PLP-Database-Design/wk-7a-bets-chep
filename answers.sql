-- question one
-- Create a new table to store the normalized data
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert normalized data into the new table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        STRING_SPLIT(Products, ',') AS value
    FROM ProductDetail
) AS SplitProducts;

-- question two

-- Create the Orders table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the OrderProducts table to store OrderID, Product, and Quantity
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;