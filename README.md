#  SQL Data Warehouse and Data Analytics Project
This project delivers a modern data warehouse which focuses on building clean, organized data pipeline and covers important aspects such as ETL Pipeline Development, Data Cleaning, Data Modelling and Data Analytics
## Project Division 
This Project focuses into two different sections:
- Data Engineering
- Data Analytics and Reporting

## Data Engineering
In this section of the project I have performed following tasks:<br>
<br>
_(I have performed the entire task using PL/PostgreSQL)_
- Implemented Medallion Architecture to develop data pipeline for more high quality data flow.
- Developed ETL Pipeline (Extract, Transform, Load)
- Ingested raw data from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) data sources to BRONZE Layer.
- Performed Data Cleansing tasks for Qualitative Data (Used PL/pgSQL): Removing Duplicates, Handling Unwanted Spaces, missing and invalid data, Data Type Casting and Filtering in SILVER Layer.
- Performed Data Modeling by creating FACTS & DIMENSIONS Table for high quality data analysis in GOLD Layer.

## Data Analytics and Reporting
  *_Currently Working on Gold layer for data analytics and reporting. I will update soon!_*

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




# Data LINEAGE
Data Lineage helps us to track which helped me to track and map the flow of data into the data warehouse. <br><br>
<i>*Note: Data Lineage will be updated as we go further into the project*</i>
![Data Lineage](https://github.com/user-attachments/assets/96f4e8d6-993f-4913-834d-b4887e0883cf)

# Data Integration
From the Below diagram we get an idea about the connections between different CRM and ERP tables available in database. <br><br>
<i>*Note: Data Integration will be updated as we go further into the project*</i>
![Integration](https://github.com/user-attachments/assets/31a25139-f89f-4c44-8ef1-2515c4760ac0)

