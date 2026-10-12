# 🛒 Retail Sales & Profitability Analytics

<p align="center">
  <a href="#project-overview">
    <img src="https://img.shields.io/badge/Project-Retail%20Analytics-0ea5e9?style=for-the-badge" alt="Retail Analytics">
  </a>
  <a href="#data-pipeline">
    <img src="https://img.shields.io/badge/Workflow-End--to--End-8b5cf6?style=for-the-badge" alt="End-to-End Workflow">
  </a>
  <a href="#power-bi-dashboard">
    <img src="https://img.shields.io/badge/Status-Completed-22c55e?style=for-the-badge" alt="Completed">
  </a>
</p>

<p align="center">
  <a href="#excel--power-query">
    <img src="https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel">
  </a>
  <a href="#excel--power-query">
    <img src="https://img.shields.io/badge/Power%20Query-217346?style=for-the-badge&logo=microsoft&logoColor=white" alt="Power Query">
  </a>
  <a href="#sql-server">
    <img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="SQL Server">
  </a>
  <a href="#power-bi-dashboard">
    <img src="https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" alt="Power BI">
  </a>
</p>

<a id="project-overview"></a>

## 🎯 Project Overview

An end-to-end retail analytics project that transforms raw Excel data into a validated SQL Server data model and an interactive Power BI report.

The project demonstrates practical skills in data cleaning, data modeling, SQL validation, business analysis, DAX, and dashboard design.

<p align="center">
  <a href="screenshots/data-pipeline-overview.jpg">
    <img
      src="screenshots/data-pipeline-overview.jpg"
      alt="Retail Sales Analytics Data Pipeline"
      width="100%"
    >
  </a>
</p>

> [!NOTE]
> This project uses synthetic data for educational and portfolio purposes.

<a id="data-pipeline"></a>

## 🔄 Data Pipeline

```text
Raw Excel → Power Query → Clean CSV → SQL Server Staging
→ Final dbo Model → Data Quality Checks → SQL Analysis → Power BI Dashboard
<a id="excel--power-query"></a>
🧹 Excel & Power Query
I prepared the source data for analysis using Excel and Power Query.
- Removed exact duplicate records.
- Trimmed and standardized text fields.
- Applied appropriate data types.
- Converted quantity fields to whole numbers.
- Preserved missing values without inventing replacements.
- Exported cleaned tables as CSV files for SQL Server loading.
<a id="sql-server"></a>
🗄️ SQL Server
I built a structured relational model using a staging-to-final-table approach.
Staging layer
CSV files were first loaded into staging tables:
- stg_Customers
- stg_Orders
- stg_SalesLines
- stg_Products
- stg_ProductTypes
- stg_SalesTargets
Final model
The staging data was transformed into typed and validated dbo tables:
Customers (1) ───< Orders (1) ───< SalesLines >─── (1) Products >─── (1) ProductTypes
The model includes:
- Primary keys and foreign keys.
- INT, DATE, DECIMAL, and NVARCHAR data types.
- Transaction-safe loading scripts.
- Duplicate-key checks.
- Orphan-record checks.
- Staging-to-final row-count reconciliation.
- Reusable SQL scripts for loading, validation, and analysis.
<a id="analysis"></a>
📊 SQL Analysis
I used SQL to answer business questions related to:
- Monthly sales, cost, profit, and profit margin.
- Product and category profitability.
- Regional sales-target attainment.
- Discount impact on revenue and profit.
- Repeat customers and average order value.
- Product-catalog and transactional-data consistency.
<a id="power-bi-dashboard"></a>
🟡 Power BI Dashboard
I connected Power BI to the validated SQL Server dbo tables and built a semantic model for reporting.
The report includes:
- Executive KPI overview.
- Monthly sales and profit trends.
- Product and category profitability analysis.
- Regional target-attainment analysis.
- Customer and repeat-purchase analysis.
- Interactive filters for date, region, product category, and customer segment.
Key DAX measures include:
- Total Sales
- Total Cost
- Total Profit
- Profit Margin
- Average Order Value
- Target Attainment
<a id="repository-structure"></a>
📂 Repository Structure
retail-sales-profitability-analytics/
│
├── docs/
│   ├── data_dictionary.md
│   └── data_quality_log.md
│
├── excel/
│   ├── Retail_Sales_Analytics_Raw.xlsx
│   └── Retail_Sales_Analytics_Clean.xlsx
│
├── powerbi/
│   └── Retail_Sales_Analytics.pbix
│
├── screenshots/
│   ├── data-pipeline-overview.jpg
│   └── dashboard-overview.png
│
├── sql/
│   ├── 00_staging_import.md
│   ├── 01_create_final_tables.sql
│   ├── 02_load_from_staging.sql
│   ├── 03_data_quality_checks.sql
│   └── 04_profitability_analysis.sql
│
└── README.md
🛠️ Skills Demonstrated
- Data cleaning with Excel and Power Query.
- CSV-based data exchange workflows.
- SQL Server staging and relational data modeling.
- SQL validation and business analysis.
- Data modeling and DAX in Power BI.
- Interactive dashboard design.
- Clear documentation and GitHub project presentation.
