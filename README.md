# Retail Sales & Profitability Analytics

An end-to-end retail analytics project that uses Excel, Power Query, SQL Server, and Power BI to answer where sales come from, which products generate profit, and how customer behavior varies across segments and regions.

[Download the Power BI report](power-bi/Retail_Sales_Analytics.pbix) · [SQL setup](sql/00_staging_import.md) · [Data dictionary](docs/data_dictionary.md) · [Data quality log](docs/data_quality_log.md)

The dataset is synthetic and intended for portfolio and learning use. It contains 520 orders, 1,073 sales lines, 28 products, 100 customer records, and three regions.

## Data pipeline

[![Retail analytics workflow from raw Excel through Power Query and SQL Server to Power BI](screenshots/data-pipeline-overview.jpg)](screenshots/data-pipeline-overview.jpg)

## Explore the report

Download the PBIX and open it in Power BI Desktop. Use the saved data to explore the report before refreshing. Use the page navigator and date and region filters to compare results.

| Page | What to explore |
| --- | --- |
| Executive Overview | Sales, cost, profit and average order value, with trends and period comparisons |
| Product Performance | Product and category performance and a scatter plot comparing sales with profit |
| Customer Analysis | Customer segments, repeat purchases and orders per customer |
| Regional Performance | Compare Baku, Ganja and Sumqayit by sales, profit, margin and product mix |

On the product scatter plot, hover over a point for the product tooltip, or right-click and choose **Drill through → Product Details** for a deeper view. Both pages are hidden from the main navigator.

## What the data shows

These full-dataset benchmarks were independently calculated from the cleaned Excel workbook. Clear the report filters before comparing totals.

| Region | Net sales | Gross profit | Gross margin |
| --- | ---: | ---: | ---: |
| Sumqayit | 6,055.14 | 2,076.94 | 34.30% |
| Baku | 5,887.48 | 1,967.62 | 33.42% |
| Ganja | 5,779.95 | 1,939.10 | 33.55% |
| **Total** | **17,722.57** | **5,983.67** | **33.76%** |

Sumqayit leads on sales, profit and margin. Baku sells more than Ganja but has a lower margin, so sales volume alone gives a different picture of regional performance.

Net sales equal quantity × transaction unit price × (1 − discount). Gross profit subtracts quantity × product unit cost from net sales. Gross margin divides gross profit by net sales. The margin reflects product cost and discounts in the dataset.

## Reproduce the analysis

1. Start with the [raw Excel workbook](excel/Retail_Sales_Analytics_Raw.xlsx), or use the [cleaned workbook](excel/Retail_Sales_Analytics_Clean.xlsx) as the input to SQL Server. The [data quality log](docs/data_quality_log.md) documents duplicate handling, text and date normalization, and how the missing segment was represented.
2. Create a fresh SQL Server database and follow the [staging import instructions](sql/00_staging_import.md). Run scripts 01–04 in order to create and load the final schema, check it, and generate the analytical outputs.
3. Compare the first result from [the profitability query](sql/04_profitability_analysis.sql) with the benchmarks above. The query file also contains category and regional target analysis.
4. To refresh the PBIX against your own environment, inspect its queries in **Transform data** and update their source connections to your local data. Set credentials in **Data source settings**, then refresh and reconcile totals. Source paths and credentials depend on your setup.

```text
Raw Excel → Power Query → Clean Excel → CSV staging → SQL Server → Power BI
```
