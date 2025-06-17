-- drop schema if exists Vendi_cose_spa;
create schema Vendi_cose_spa;
use vendi_cose_spa;

-- drop table if exists Category;
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- drop table if exists Product;
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- drop table if exists Warehouse;
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100)
);

-- drop table if exists Store;
CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100)
);

-- drop table if exists Warehouse_Stock;
CREATE TABLE Warehouse_Stock (
    WarehouseID INT,
    ProductID INT,
    Quantity INT DEFAULT 0,
    PRIMARY KEY (WarehouseID, ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- drop table if exists Restock_Threshold;
CREATE TABLE Restock_Threshold (
    WarehouseID INT,
    CategoryID INT,
    Threshold INT,
    PRIMARY KEY (WarehouseID, CategoryID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- drop table if exists Warehouse_Store;
CREATE TABLE Warehouse_Store (
    WarehouseID INT,
    StoreID INT,
    PRIMARY KEY (WarehouseID, StoreID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

-- drop table if exists Sales;
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    StoreID INT,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


INSERT INTO Category VALUES
(1, 'Alimentari')
, (2, 'Bevande')
, (3, 'Cura Casa')
, (4, 'Cosmetica')
, (5, 'Surgelati')
, (6, 'Snack')
;

INSERT INTO Product VALUES
(101, 'Pasta', 1)
, (102, 'Acqua Naturale', 2)
, (103, 'Detersivo Piatti', 3)
, (104, 'Shampoo', 4)
, (105, 'Piselli Surgelati', 5)
, (106, 'Patatine', 6)
, (107, 'Mozzarella', 1)
, (108, 'Succo di Frutta', 2)
, (109, 'Ammorbidente', 3)
, (110, 'Cioccolatini', 6)
;

INSERT INTO Warehouse VALUES
(1, 'Magazzino Nord')
, (2, 'Magazzino Sud')
;

INSERT INTO Store VALUES
(1, 'Supermercato Milano')
, (2, 'Supermercato Roma')
, (3, 'Supermercato Napoli')
;

INSERT INTO Warehouse_Stock VALUES
(1, 101, 100)
, (1, 102, 120)
, (1, 103, 80)
, (1, 104, 90)
, (1, 105, 70)
, (1, 106, 110)
, (1, 107, 60)
, (1, 108, 95)
, (1, 109, 85)
, (1, 110, 100)
, (2, 101, 80) 
, (2, 102, 100)
, (2, 103, 90)
, (2, 104, 70) 
, (2, 105, 60)
, (2, 106, 100) 
, (2, 107, 55) 
, (2, 108, 85)
, (2, 109, 75)
,(2, 110, 95)
;


INSERT INTO Restock_Threshold VALUES
(1, 1, 60)
, (1, 2, 80)
, (1, 3, 70)
, (1, 4, 50)
, (1, 5, 40)
, (1, 6, 60)
, (2, 1, 50)
, (2, 2, 60) 
, (2, 3, 60) 
, (2, 4, 40) 
, (2, 5, 30) 
, (2, 6, 55)
;

INSERT INTO Warehouse_Store VALUES
(1, 1)
, (1, 2)
, (2, 3)
;



INSERT INTO Sales (StoreID, ProductID, Quantity, SaleDate) VALUES
(1, 101, 5, '2025-01-05')
, (1, 106, 3, '2025-02-18')
, (2, 104, 2, '2025-03-12')
, (2, 110, 4, '2025-04-22')
, (3, 102, 7, '2025-05-09')
, (3, 103, 6, '2025-06-30')
, (1, 105, 3, '2025-07-19')
, (2, 109, 4, '2025-08-25')
, (3, 107, 5, '2025-09-07')
, (1, 108, 6, '2025-10-11')
, (3, 110, 4, '2025-11-15')
, (2, 101, 3, '2025-12-05')
;
