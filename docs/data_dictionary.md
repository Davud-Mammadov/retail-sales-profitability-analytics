# Data Dictionary

## Project Overview
This project uses a synthetic retail sales dataset to analyze sales performance, profitability, product categories, customers, and sales targets.

## Data Tables

### 1. SalesLines_Raw
**Purpose:** Main sales fact table.
- One row represents one order line.
- `SalesLineID` uniquely identifies a sales line.
- `OrderID` and `ProductID` may repeat across multiple rows.

### 2. Orders_Raw
**Purpose:** Order-level information.
- One row represents one order.
- `OrderID` uniquely identifies an order.

### 3. Products_Raw
**Purpose:** Product dimension table.
- One row represents a product.
- `ProductID` uniquely identifies a product.

### 4. Customers_Raw
**Purpose:** Customer dimension table.
- One row represents a customer.
- `CustomerID` uniquely identifies a customer.

### 5. ProductTypes_Raw
**Purpose:** Product type dimension table.
- One row represents a product type.
- `ProductTypeID` uniquely identifies a product type.

### 6. SalesTargets_Raw
**Purpose:** Monthly sales targets by region.
- One row represents a month and region combination.
- The combination of `MonthStart` and `Region` uniquely identifies a record.

## Data Quality Notes
The raw dataset intentionally contains data quality issues for practice, including a duplicate sales line and other formatting or missing-value issues.

These issues will be investigated and documented during the data cleaning stage.
