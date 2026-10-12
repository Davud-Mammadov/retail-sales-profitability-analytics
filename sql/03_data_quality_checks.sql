-- Staging-to-final row reconciliation
SELECT 'Customers' AS TableName,
       (SELECT COUNT(*) FROM dbo.stg_Customers) AS StagingRows,
       (SELECT COUNT(*) FROM dbo.Customers) AS FinalRows
UNION ALL
SELECT 'ProductTypes', COUNT(*), (SELECT COUNT(*) FROM dbo.ProductTypes)
FROM dbo.stg_ProductTypes
UNION ALL
SELECT 'Products', COUNT(*), (SELECT COUNT(*) FROM dbo.Products)
FROM dbo.stg_Products
UNION ALL
SELECT 'Orders', COUNT(*), (SELECT COUNT(*) FROM dbo.Orders)
FROM dbo.stg_Orders
UNION ALL
SELECT 'SalesLines', COUNT(*), (SELECT COUNT(*) FROM dbo.SalesLines)
FROM dbo.stg_SalesLines
UNION ALL
SELECT 'SalesTargets', COUNT(*), (SELECT COUNT(*) FROM dbo.SalesTargets)
FROM dbo.stg_SalesTargets;

-- Duplicate primary-key checks: an empty result means no duplicates were found.
SELECT 'Customers' AS TableName, CAST(CustomerID AS NVARCHAR(50)) AS DuplicateKey, COUNT(*) AS Occurrences
FROM dbo.Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1
UNION ALL
SELECT 'Orders', CAST(OrderID AS NVARCHAR(50)), COUNT(*)
FROM dbo.Orders
GROUP BY OrderID
HAVING COUNT(*) > 1
UNION ALL
SELECT 'Products', CAST(ProductID AS NVARCHAR(50)), COUNT(*)
FROM dbo.Products
GROUP BY ProductID
HAVING COUNT(*) > 1
UNION ALL
SELECT 'SalesLines', CAST(SalesLineID AS NVARCHAR(50)), COUNT(*)
FROM dbo.SalesLines
GROUP BY SalesLineID
HAVING COUNT(*) > 1;

-- Foreign-key checks: an empty result means no orphan records were found.
SELECT 'Orders without customer' AS Issue, CAST(o.OrderID AS NVARCHAR(50)) AS RecordID
FROM dbo.Orders AS o
LEFT JOIN dbo.Customers AS c ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL
UNION ALL
SELECT 'Products without product type', CAST(p.ProductID AS NVARCHAR(50))
FROM dbo.Products AS p
LEFT JOIN dbo.ProductTypes AS pt ON pt.ProductTypeID = p.ProductTypeID
WHERE pt.ProductTypeID IS NULL
UNION ALL
SELECT 'Sales lines without order', CAST(sl.SalesLineID AS NVARCHAR(50))
FROM dbo.SalesLines AS sl
LEFT JOIN dbo.Orders AS o ON o.OrderID = sl.OrderID
WHERE o.OrderID IS NULL
UNION ALL
SELECT 'Sales lines without product', CAST(sl.SalesLineID AS NVARCHAR(50))
FROM dbo.SalesLines AS sl
LEFT JOIN dbo.Products AS p ON p.ProductID = sl.ProductID
WHERE p.ProductID IS NULL;
