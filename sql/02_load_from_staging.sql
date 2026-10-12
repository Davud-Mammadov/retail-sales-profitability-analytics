SET XACT_ABORT ON;

BEGIN TRANSACTION;

INSERT INTO dbo.Customers (
    CustomerID, CustomerName, City, Segment, RegistrationDate
)
SELECT
    CustomerID,
    LTRIM(RTRIM(CustomerName)),
    LTRIM(RTRIM(City)),
    NULLIF(LTRIM(RTRIM(Segment)), ''),
    RegistrationDate
FROM dbo.stg_Customers;

INSERT INTO dbo.ProductTypes (ProductTypeID, ProductType)
SELECT
    TRY_CONVERT(INT, ProductTypeID),
    LTRIM(RTRIM(ProductType))
FROM dbo.stg_ProductTypes;

INSERT INTO dbo.Products (
    ProductID, ProductName, ProductTypeID, UnitCost, ListPrice, Supplier
)
SELECT
    TRY_CONVERT(INT, ProductID),
    LTRIM(RTRIM(ProductName)),
    TRY_CONVERT(INT, ProductTypeID),
    TRY_CONVERT(DECIMAL(12, 2), REPLACE(UnitCost, ',', '.')),
    TRY_CONVERT(DECIMAL(12, 2), REPLACE(ListPrice, ',', '.')),
    LTRIM(RTRIM(Supplier))
FROM dbo.stg_Products;

INSERT INTO dbo.Orders (OrderID, OrderDate, CustomerID, Region)
SELECT
    TRY_CONVERT(INT, OrderID),
    TRY_CONVERT(DATE, OrderDate, 104),
    TRY_CONVERT(INT, CustomerID),
    LTRIM(RTRIM(Region))
FROM dbo.stg_Orders;

INSERT INTO dbo.SalesLines (
    SalesLineID, OrderID, ProductID, Quantity, UnitPrice, DiscountPct
)
SELECT
    TRY_CONVERT(INT, SalesLineID),
    TRY_CONVERT(INT, OrderID),
    TRY_CONVERT(INT, ProductID),
    TRY_CONVERT(INT, Quantity),
    TRY_CONVERT(DECIMAL(12, 2), REPLACE(UnitPrice, ',', '.')),
    TRY_CONVERT(DECIMAL(5, 4), REPLACE(DiscountPct, ',', '.'))
FROM dbo.stg_SalesLines;

INSERT INTO dbo.SalesTargets (MonthStart, Region, SalesTarget)
SELECT
    TRY_CONVERT(DATE, MonthStart, 104),
    LTRIM(RTRIM(Region)),
    TRY_CONVERT(DECIMAL(12, 2), REPLACE(SalesTarget, ',', '.'))
FROM dbo.stg_SalesTargets;

COMMIT TRANSACTION;
