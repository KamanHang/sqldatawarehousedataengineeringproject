
### ❗Things to Consider❗
The provided dataset was anonymous so I provided a fictional name "Bike Haven Collective" - a company that sells bikes, related acessories and clothing.
#  SQL Data Warehouse and Data Analytics Project
This project delivers a modern data warehouse which focuses on building clean, organized data pipeline and covers important aspects such as ETL Pipeline Development, Data Cleaning, Data Modelling and Data Analytics.

## Project Division 
This Project focuses into two different sections:
- Data Engineering
- Data Analytics and Reporting

## Data Engineering 👷🏻‍♂️
In this section of the project I have performed following tasks:<br>
<br>
_(I have performed the entire task using PL/PostgreSQL)_
- Implemented Medallion Architecture to develop data pipeline for more high quality data flow.
- Developed ETL Pipeline (Extract, Transform, Load)
- Ingested raw data from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) data sources.
- Performed:
    - Data Cleansing tasks (Removing Duplicates, Handling Unwanted Spaces, missing and invalid data, Data Type Casting and Filtering)
    - Data Standardization
    - Data Normalization
    - Data Enrichment
    - Data Integration for Qualitative Data
- Performed Data Modeling by creating FACTS & DIMENSIONS Table for high quality data analysis in GOLD Layer.


# ⛩️ Data Architecture
![DataArchitecturedrawio](https://github.com/user-attachments/assets/8f124cd0-6690-4455-80d9-8d99634a1dc1)

One of the important thing I was exposed during this project is the Medallion Architecture.<br>
Medallion Architecture consist three layers which helped me design and build modular and robust data warehouse.
- ### **Bronze Layer:**
     - In this layer, I have ingested raw data from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) CSV files into PostgreSQL.
- ### **Silver Layer:**
     - In this layer, I have performed data cleansing (Handling Null values, empty spaces), standardization, normalization, enrichment and derived columns tasks.
- ### **Gold Layer:**
     - In this layer, I have created **Data Model: Star Schema**, in which I have created Fact and Dimension Tables for advance data analytics.

# Data LINEAGE (Data Flow)
<i>*Note: Final Updated Data Lineage*</i>
![Data Lineage](https://github.com/user-attachments/assets/96f4e8d6-993f-4913-834d-b4887e0883cf)

# Data Modeling (Star Schema)
- **STAR SCHEMA** <br> <br>
Star Schema is a multi-dimensional data model for organizing data in a way that makes data analytical tasks easier and helps non technical people easy to understand and get insights from the data.

    - ### Dimension Table
       - dim_customers
       - dim_products
    - ### Facts Table
       - fact_sales
 
 ### _For more details check [Data Catlog](https://github.com/KamanHang/sqldatawarehousedataengineeringproject/blob/main/ProjectScripts/data_catlog.md) of Gold Layer_ 
![StarSchema](https://github.com/user-attachments/assets/21e97013-0699-4f1e-b51f-b7cecdf9ad5e)



## Data Analytics and Reporting 📊

- I have analyzed the sales data for different analysis and created an interactive Power BI dashboard:
 
![PowerBI](https://github.com/user-attachments/assets/a0f7c76d-8011-431c-81d0-37d1dffd23cb)

