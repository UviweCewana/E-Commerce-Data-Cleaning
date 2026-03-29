# E-Commerce Data Cleaning Pipeline








## Project Overview

A structured data cleaning pipeline built in Google BigQuery to transform inconsistent e-commerce transaction data into a clean, analysis-ready dataset. The project applies practical SQL techniques to handle real-world data quality issues across product, pricing, quantity, and date fields.

## Business Context

E-commerce data is often fragmented and inconsistent due to multiple input sources and manual entry. This creates issues such as:

Misclassified products impacting category-level reporting
Invalid quantities and pricing distorting revenue metrics
Inconsistent date formats breaking time-based analysis
Poor data standardisation reducing overall data reliability

This pipeline resolves these issues to ensure accurate reporting, cleaner dashboards, and more reliable business insights.

| Column           | Description              | Issues Present                                                       |
| ---------------- | ------------------------ | -------------------------------------------------------------------- |
| `ID`             | Unique record identifier | None                                                                 |
| `Customer_Name`  | Customer name            | Incorrect column reference (string literal in query)                 |
| `Order_ID`       | Unique order identifier  | None                                                                 |
| `Total`          | Total order value        | Dependent on unclean price/quantity inputs                           |
| `Status`         | Order status             | Inconsistent casing                                                  |
| `Payment_Method` | Payment type             | Formatting inconsistencies                                           |
| `Product`        | Product name             | Inconsistent casing, leading/trailing spaces                         |
| `Category`       | Product category         | Missing values, inconsistent mapping                                 |
| `Quantity`       | Units purchased          | Negative values, nulls, incorrect data types                         |
| `Price`          | Product price            | Text values (e.g. "four hundred"), currency symbols, invalid formats |
| `Order_Date`     | Order date               | Multiple date formats (YYYY-MM-DD, DD/MM/YYYY, etc.)                 |


The pipeline consolidates multiple cleaning steps into a single transformation query:

### 1. Text Standardisation
Applied INITCAP and TRIM to normalise product naming
Ensured consistent formatting for downstream grouping and analysis
### 2. Category Normalisation
Mapped products to correct categories using CASE logic
Resolved missing and inconsistent category values
Standardised output categories (Electronics, Clothing, Home, Sports, Books)
### 3. Quantity Cleaning
Converted values using SAFE_CAST
Removed negatives using ABS()
Replaced nulls with 0 using IFNULL
### 4. Price Cleaning
Handled text-based anomalies (e.g. "four hundred")
Removed currency symbols using REPLACE
Enforced numeric format with SAFE_CAST
Standardised all values to positive floats
### 5. Date Standardisation
Normalised multiple date formats using SAFE.PARSE_DATE
Supported formats:
YYYY-MM-DD
DD/MM/YYYY
MM/DD/YYYY
Mon DD YYYY
Consolidated into a single clean date field
### 6. Final Output
Produced a clean, structured dataset with:
Standardised product and category fields
Valid numeric quantity and price values
Consistent, analysis-ready date field
Tools & Stack
Google BigQuery – Data warehousing and query execution
SQL – Data cleaning, transformation, and business logic implementation
Key Outcome

Raw, inconsistent transaction data → clean, structured dataset ready for:

##Revenue analysis
Product performance tracking
Category-level reporting
Time-series analysis
What This Demonstrates
Ability to clean and standardise messy, real-world data
Strong SQL handling of edge cases and invalid inputs
Application of business logic within data transformations
Building analysis-ready datasets from unreliable raw inputs
Thinking in terms of downstream business impact, not just queries
