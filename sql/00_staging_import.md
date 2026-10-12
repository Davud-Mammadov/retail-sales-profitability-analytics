# SQL Loading Workflow

## Source and staging layer

The cleaned Excel workbook was exported to CSV files and imported with the SQL Server Import Flat File Wizard.

The wizard loaded one staging table for each source:

- `dbo.stg_Customers`
- `dbo.stg_Orders`
- `dbo.stg_SalesLines`
- `dbo.stg_Products`
- `dbo.stg_ProductTypes`
- `dbo.stg_SalesTargets`

Staging preserves imported source values before they are loaded into the final relational model. In this project, most staging columns are text fields; the wizard inferred `smallint` for `stg_Customers.CustomerID` and `date` for `stg_Customers.RegistrationDate`.

## Final model

Run the scripts in this order:

1. `01_create_final_tables.sql`
2. `02_load_from_staging.sql`
3. `03_data_quality_checks.sql`
4. `04_profitability_analysis.sql`

The final tables use explicit data types, primary keys, foreign keys, and validation checks. Power BI should connect to the final `dbo` tables, not the staging tables.
