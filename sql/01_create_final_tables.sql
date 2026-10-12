CREATE TABLE dbo.Customers (
    CustomerID INT NOT NULL PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Segment NVARCHAR(50) NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE dbo.ProductTypes (
    ProductTypeID INT NOT NULL PRIMARY KEY,
    ProductType NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Products (
    ProductID INT NOT NULL PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    ProductTypeID INT NOT NULL,
    UnitCost DECIMAL(12, 2) NOT NULL,
    ListPrice DECIMAL(12, 2) NOT NULL,
    Supplier NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Products_ProductTypes
        FOREIGN KEY (ProductTypeID) REFERENCES dbo.ProductTypes(ProductTypeID),
    CONSTRAINT CK_Products_UnitCost CHECK (UnitCost >= 0),
    CONSTRAINT CK_Products_ListPrice CHECK (ListPrice >= 0)
);

CREATE TABLE dbo.Orders (
    OrderID INT NOT NULL PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);

CREATE TABLE dbo.SalesLines (
    SalesLineID INT NOT NULL PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(12, 2) NOT NULL,
    DiscountPct DECIMAL(5, 4) NOT NULL,
    CONSTRAINT FK_SalesLines_Orders
        FOREIGN KEY (OrderID) REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_SalesLines_Products
        FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID),
    CONSTRAINT CK_SalesLines_Quantity CHECK (Quantity > 0),
    CONSTRAINT CK_SalesLines_UnitPrice CHECK (UnitPrice >= 0),
    CONSTRAINT CK_SalesLines_DiscountPct
        CHECK (DiscountPct >= 0 AND DiscountPct <= 1)
);

CREATE TABLE dbo.SalesTargets (
    MonthStart DATE NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    SalesTarget DECIMAL(12, 2) NOT NULL,
    CONSTRAINT PK_SalesTargets PRIMARY KEY (MonthStart, Region),
    CONSTRAINT CK_SalesTargets_SalesTarget CHECK (SalesTarget >= 0)
);
