CREATE DATABASE JunctionStore;
USE JunctionStore;



CREATE TABLE Customer (
    CustomerID     INT AUTO_INCREMENT PRIMARY KEY,
    FirstName      VARCHAR(50) NOT NULL,
    LastName       VARCHAR(50) NOT NULL,
    Phone          VARCHAR(20),
    Email          VARCHAR(100),
    Address        VARCHAR(255)
);


CREATE TABLE Supplier (
    SupplierID     INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName   VARCHAR(100) NOT NULL,
    ContactName    VARCHAR(100),
    Phone          VARCHAR(20)
);


CREATE TABLE Product (
    ProductID       INT AUTO_INCREMENT PRIMARY KEY,
    ProductName     VARCHAR(100) NOT NULL,
    Category        VARCHAR(50),
    Price           DECIMAL(10,2) NOT NULL,
    QuantityInStock INT DEFAULT 0,
    SupplierID      INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);


CREATE TABLE `Order` (
    OrderID      INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate    DATE NOT NULL,
    CustomerID   INT,
    TotalAmount  DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE OrderDetail (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID       INT,
    ProductID     INT,
    Quantity      INT NOT NULL,
    Price         DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



INSERT INTO Supplier (SupplierName, ContactName, Phone) VALUES
  ('Lephalale Bricks Co.', 'chris van derwalt', '0147649789'),
  ('Cement Masters', '', '0147639000');


INSERT INTO Product (ProductName, Category, Price, QuantityInStock, SupplierID) VALUES
  ('Standard Brick', 'Building Material', 1.50, 1000, 1),
  ('Portland Cement 50kg', 'Building Material', 75.00, 200, 2),
  ('Roofing Tile', 'Roofing', 8.00, 500, 1);


INSERT INTO Customer (FirstName, LastName, Phone, Email, Address) VALUES
  ('Thabo', 'Ngema', '0825551234', 'thabo.tapala@gmail.com', '789 Contractor St, Marapong'),
  ('Maria', 'Van Staden', '0834445678', 'maria.tlou@gmail.com', '321 Homeowner Ave, Marapong');


INSERT INTO `Order` (OrderDate, CustomerID, TotalAmount) VALUES
  ('2025-08-01', 1, 1500.00),
  ('2025-08-02', 2, 600.00);


INSERT INTO OrderDetail (OrderID, ProductID, Quantity, Price) VALUES
  (1, 1, 800, 1.50),
  (1, 2, 20, 75.00),
  (2, 3, 75, 8.00);
  
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    p.ProductName,
    od.Quantity,
    od.Price,
    (od.Quantity * od.Price) AS LineTotal
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN OrderDetail od ON o.OrderID = od.OrderID
JOIN Product p ON od.ProductID = p.ProductID
ORDER BY o.OrderID;

select * from OrderDetail;