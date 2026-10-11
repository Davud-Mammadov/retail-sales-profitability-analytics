# Data Quality & Cleaning Log

## Overview
This document logs all identified data quality issues within the raw dataset (`Retail_Sales_Analytics_Raw.xlsx`), outlines the resolution strategy for each issue, and records the exact steps applied during the Power Query / Excel data cleaning phase before importing into SQL Server and Power BI.

---

## Data Profiling & Audit Tools (Power Query View Tab)
To systematically audit the raw dataset, the following data profiling features were enabled in Power Query Editor (**View** tab):

* **Column Quality:** Used to monitor the percentage of Valid, Error, and Empty values per column, enabling immediate localization of the missing `Segment` in `Customers_Raw`.
* **Column Distribution:** Applied to inspect value histograms and compare *Distinct* vs. *Unique* record counts, directly identifying the duplicated `SalesLineID`.
* **Column Profile:** Used to analyze entire dataset statistics (*Column profiling based on entire data set*), ensuring no hidden irregularities remained.

---

## Identified Data Quality Issues & Resolutions

| Issue ID | Table | Column(s) | Description | Impact | Proposed Action | Status / Resolution |
|---|---|---|---|---|---|---|
| **DQ-001** | `SalesLines_Raw` | `SalesLineID` | Duplicate record found (`SalesLineID = 900048`, rows 47 & 1074). | Distorts total sales volume and revenue calculations (1074 total rows vs 1073 unique). | Remove duplicate row using `Remove Duplicates`. | **Resolved:** Row count reduced to 1073. Data type set to Whole Number. |
| **DQ-002** | `Customers_Raw` | `Segment` | Missing/Null segment value for Customer ID `2038` (Aysel Mammadov). | Causes incomplete customer segmentation and fragmented `GROUP BY` results. | Replace `null` with `Unknown` to preserve data integrity without guessing. | **Resolved:** Replaced `null` with explicit `Unknown` value. |
| **DQ-003** | `Customers_Raw` | `RegistrationDate` | Date formats require explicit casting across rows. | Potential parsing issues during database import or DAX logic. | Ensure standardized `YYYY-MM-DD` date formatting. | **Resolved:** Standardized to Date type in Power Query. |
| **DQ-004** | Text Fields | `Region`, `City`, `ProductName`, `Supplier` | Potential hidden leading/trailing spaces in text strings. | Can cause failed JOINs or fragmented grouping in Power BI/SQL. | Apply `TRIM()` function across all text columns. | **Resolved:** Applied `Trim` transform across text attributes in `Orders`, `Customers`, and `Products`. |

---

## Cleaning Strategy & Pipeline Progress

1. **Phase 1 — Power Query / Excel (Completed):**
   * Identified table granularity across all 6 entities.
   * Leveraged Power Query profiling tools (**Column Quality**, **Column Distribution**, **Column Profile**).
   * Removed exact duplicates in `SalesLines`.
   * Replaced missing values with `Unknown` in `Customers[Segment]`.
   * Applied `TRIM()` formatting to text attributes (`City`, `Region`, `ProductName`, `Supplier`).
   * Renamed queries by removing `_Raw` suffixes (`SalesLines`, `Orders`, `Products`, `Customers`, `ProductTypes`, `SalesTargets`).
   * Exported cleaned dataset as `Retail_Sales_Analytics_Clean.xlsx`.

2. **Phase 2 — SQL Server (Next Step):**
   * Create relational database schema with Primary and Foreign Keys (`PK`/`FK`).
   * Import clean dataset into SQL Server.
   * Write analytical SQL queries using `JOIN`, `GROUP BY`, `HAVING`, `CTE`, and Window Functions.

3. **Phase 3 — Power BI Visualization:**
   * Connect to SQL Server database.
   * Implement DAX measures (`Sales`, `Cost`, `Profit`, `Profit Margin`, `AOV`, `Target Attainment`).
   * Reconcile metrics against SQL outputs and publish executive dashboard.
