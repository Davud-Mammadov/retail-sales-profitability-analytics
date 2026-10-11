# Data Quality & Cleaning Log

## Overview
This document logs all identified data quality issues within the raw dataset (`Retail_Sales_Analytics_Raw.xlsx`) and outlines the resolution strategy for each issue before conducting analysis in SQL and Power BI.

---

## Identified Data Quality Issues

| Issue ID | Table | Column(s) | Description | Impact | Proposed Action |
|---|---|---|---|---|---|
| **DQ-001** | `SalesLines_Raw` | `SalesLineID` | Duplicate record found for `SalesLineID = 900048`. | Distorts total sales volume and revenue calculations (1074 total rows vs 1073 unique). | Remove duplicate row during data cleaning / Power Query. |
| **DQ-002** | `Customers_Raw` | `Segment` | Missing/Null segment value for Customer ID `2038` (Aysel Mammadov). | Causes incomplete customer segmentation analytics. | Flag as `Unknown` or handle as NULL according to business rule. |
| **DQ-003** | `Customers_Raw` | `RegistrationDate` | Date formats require explicit casting across rows. | Potential parsing issues during database import or DAX logic. | Ensure standardized `YYYY-MM-DD` date formatting. |
| **DQ-004** | Text Fields | `Region`, `City` | Potential hidden leading/trailing spaces in text strings. | Can cause failed JOINs or fragmented grouping in Power BI/SQL. | Apply `TRIM()` function in Power Query / SQL. |

---

## Cleaning Strategy
1. **Excel & Power Query Phase:** Identify table granularity, remove duplicates, trim text whitespaces, and validate foreign key integrity across tables.
2. **SQL Server Phase:** Create relational database structure with Primary and Foreign Keys, import clean tables, and run analytical queries.
3. **Power BI Phase:** Connect to SQL Server, implement DAX measures (Sales, Cost, Profit, Margin), and build executive dashboard.
