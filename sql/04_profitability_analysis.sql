-- Portfolio KPI summary
SELECT
    ROUND(SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct)), 2) AS TotalSales,
    ROUND(SUM(sl.Quantity * p.UnitCost), 2) AS TotalCost,
    ROUND(
        SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct))
        - SUM(sl.Quantity * p.UnitCost),
        2
    ) AS TotalProfit,
    ROUND(
        100.0 * (
            SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct))
            - SUM(sl.Quantity * p.UnitCost)
        ) / NULLIF(SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct)), 0),
        2
    ) AS ProfitMarginPct
FROM dbo.SalesLines AS sl
INNER JOIN dbo.Products AS p ON p.ProductID = sl.ProductID;

-- Category profitability
SELECT
    pt.ProductType,
    ROUND(SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct)), 2) AS TotalSales,
    ROUND(SUM(sl.Quantity * p.UnitCost), 2) AS TotalCost,
    ROUND(
        SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct))
        - SUM(sl.Quantity * p.UnitCost),
        2
    ) AS TotalProfit,
    ROUND(
        100.0 * (
            SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct))
            - SUM(sl.Quantity * p.UnitCost)
        ) / NULLIF(SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct)), 0),
        2
    ) AS ProfitMarginPct
FROM dbo.SalesLines AS sl
INNER JOIN dbo.Products AS p ON p.ProductID = sl.ProductID
INNER JOIN dbo.ProductTypes AS pt ON pt.ProductTypeID = p.ProductTypeID
GROUP BY pt.ProductType
ORDER BY TotalProfit DESC;

-- Monthly actual sales versus target by region
WITH ActualSales AS (
    SELECT
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1) AS MonthStart,
        o.Region,
        SUM(sl.Quantity * sl.UnitPrice * (1 - sl.DiscountPct)) AS ActualSales
    FROM dbo.Orders AS o
    INNER JOIN dbo.SalesLines AS sl ON sl.OrderID = o.OrderID
    GROUP BY
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1),
        o.Region
)
SELECT
    t.MonthStart,
    t.Region,
    t.SalesTarget,
    ROUND(COALESCE(a.ActualSales, 0), 2) AS ActualSales,
    ROUND(COALESCE(a.ActualSales, 0) - t.SalesTarget, 2) AS VarianceToTarget,
    ROUND(
        100.0 * COALESCE(a.ActualSales, 0) / NULLIF(t.SalesTarget, 0),
        2
    ) AS TargetAttainmentPct
FROM dbo.SalesTargets AS t
LEFT JOIN ActualSales AS a
    ON a.MonthStart = t.MonthStart
   AND a.Region = t.Region
ORDER BY t.MonthStart, t.Region;
