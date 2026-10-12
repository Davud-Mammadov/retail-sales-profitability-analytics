# Retail Sales & Profitability Analytics

## 📌 Project Overview

End-to-end retail analytics portfolio project using Excel, Power Query, SQL Server, and Power BI.

<p align="center">
  <a href="screenshots/data-pipeline-overview.jpg">
    <img
      src="screenshots/data-pipeline-overview.jpg"
      alt="Retail Sales Analytics Data Pipeline"
      width="100%">
  </a>
</p>

> **Dataset note:** This project uses synthetic data for educational and portfolio purposes.

## 🔄 Data Pipeline

```text
Raw Excel → Power Query → Clean Excel / CSV → SQL Server Staging →
Final dbo Model → Data Quality Validation → SQL Analysis → Power BI

1. Excel and Power Query
The project begins with a raw retail dataset in Excel.
Power Query was used to:
- remove an exact duplicate sales line;
- standardize text fields and data types;
- convert Quantity to a whole number;
- preserve missing values without inventing data;
- create a cleaned dataset for SQL Server loading.
2. CSV Export and SQL Server Staging
Cleaned tables were exported to CSV and loaded with the SQL Server Import Flat File Wizard into staging tables:
- dbo.stg_Customers
- dbo.stg_Orders
- dbo.stg_SalesLines
- dbo.stg_Products
- dbo.stg_ProductTypes
- dbo.stg_SalesTargets
The staging layer preserves the imported source data before final transformation and enables repeatable validation.
3. Final Relational Model
Data was transformed from staging into typed dbo tables:
- Customers
- Orders
- SalesLines
- Products
- ProductTypes
- SalesTargets
The final SQL Server model includes:
- explicit data types: INT, DATE, DECIMAL, and NVARCHAR;
- primary keys and foreign keys;
- validation rules for quantities, prices, discounts, and targets;
- transaction-safe loading logic;
- reusable scripts for schema creation, loading, validation, and analysis.
🧩 Data Model
Customers (1) ───< Orders (1) ───< SalesLines >─── (1) Products >─── (1) ProductTypes

SalesTargets
- Monthly target by Region
- Key: MonthStart + Region
SalesLines is the main transactional table used to calculate sales, cost, discount impact, and profit.
✅ Data Quality and Validation
The workflow includes the following checks:
- duplicate primary-key validation;
- orphan-record checks across table relationships;
- staging-to-final row-count reconciliation;
- date and numeric conversion validation;
- verification that no rows were lost during the SQL load.

Final validated row counts:
Table	Rows
Customers	100
ProductTypes	5
Products	28
Orders	520
SalesLines	1,073
SalesTargets	63


📈 Initial SQL Findings
KPI	Result
Total Sales	17,722.57
Total Cost	11,738.90
Total Profit	5,983.67
Overall Profit Margin	33.76%


Additional findings:
- Dairy generated the highest total sales.
- Beverages generated the highest total profit.
- Sales, cost, profit, margin, and target-attainment logic will be reconciled between SQL Server and Power BI.

🔍 Key Business Questions
1. How do sales, profit, and margin change by month?
2. Which products and categories generate the highest profit?
3. Which regions are meeting their monthly sales targets?
4. How do discounts correlate with revenue and profit?
5. Who are the repeat customers, and what is the average order value?
6. Are there any products with sales recorded that lack a valid product-catalog entry?

🛠️ Tools and Technologies
- Excel / Power Query — source-data preparation and transformation.
- CSV — interchange format between Excel and SQL Server.
- SQL Server — staging, data modeling, transformation, validation, and analysis.
- Power BI — semantic modeling, DAX measures, dashboard design, and KPI reporting.
- Markdown / GitHub — documentation and portfolio presentation.

📂 Repository Structure
retail-sales-profitability-analytics/
│
├── Retail_Sales_Analytics_Raw.xlsx
├── README.md
│
├── docs/
│   ├── data_dictionary.md
│   └── data_quality_log.md
│
├── sql/
│   ├── 00_staging_import.md
│   ├── 01_create_final_tables.sql
│   ├── 02_load_from_staging.sql
│   ├── 03_data_quality_checks.sql
│   └── 04_profitability_analysis.sql
│
├── powerbi/              # Power BI report and model — planned
└── screenshots/          # Dashboard visuals — planned


🚀 Next Steps
- Build the Power BI data model from validated dbo tables.
- Create DAX measures for Sales, Cost, Profit, Profit Margin, Average Order Value, and Target Attainment.
- Design interactive report pages for executive KPIs, product profitability, customer analysis, and regional target performance.
- Add dashboard screenshots and the Power BI file to the repository.



Created as part of a professional data analytics portfolio.
```
