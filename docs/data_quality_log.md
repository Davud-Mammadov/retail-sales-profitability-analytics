# Data Quality & Cleaning Log

## Overview
This document logs all identified data quality issues within the raw dataset (`Retail_Sales_Analytics_Raw.xlsx`) and outlines the resolution strategy for each issue before conducting analysis in SQL and Power BI.

---

## Identified Data Quality Issues

| Issue ID | Table | Column(s) | Description | Impact | Proposed Action |
|---|---|---|---|---|---|
| **DQ-001** | `SalesLines_Raw` | `SalesLineID` | Duplicate record found for `SalesLineID = 11`. | Distorts total sales volume and revenue calculations. | Remove duplicate row during data cleaning. |
| **DQ-002** | `SalesLines_Raw` | `ProductID` | Sales lines contain `ProductID` values that do not exist in `Products_Raw`. | Prevents proper joins with the product catalog (orphaned sales). | Identify missing product references and handle via `LEFT JOIN` or clean mappings. |
| **DQ-003** | `Customers_Raw` | `RegistrationDate` | Date formats are inconsistent across rows. | Causes parsing errors during database import or DAX calculations. | Standardize to `YYYY-MM-DD` format. |
| **DQ-004** | `SalesTargets_Raw` | `SalesTarget` | Missing or null values present for certain month/region combinations. | Distorts Target vs. Actual performance tracking. | Impute missing targets or exclude incomplete periods with documentation. |

---

## Cleaning Strategy
1. **Excel Phase:** Perform initial audit and visual checks for duplicates and formatting errors.
2. **SQL Phase:** Use CTEs, window functions (`ROW_NUMBER()`), and relational joins to isolate clean data models.
3. **Power BI Phase:** Apply Power Query transformations to ensure data types and relationships remain clean and strict.
