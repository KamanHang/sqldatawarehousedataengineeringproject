-- Purpose: 
	-- The purpose of this SQL Script is to bulk insert data from csv files stored locally.

TRUNCATE TABLE bronze.crm_cust_info;
\COPY bronze.crm_cust_info FROM '/Users/mecco/Downloads/sql-data-warehouse-project/datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER;
-- SELECT count(*) FROM bronze.crm_cust_info;

TRUNCATE TABLE bronze.crm_prd_info;
\COPY bronze.crm_prd_info FROM '/Users/mecco/Downloads/sql-data-warehouse-project/datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER;
-- SELECT count(*) FROM bronze.crm_prd_info;


TRUNCATE TABLE bronze.crm_sales_details;
\COPY bronze.crm_sales_details FROM '/Users/mecco/Downloads/sql-data-warehouse-project/datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER;
-- SELECT count(*) FROM bronze.crm_sales_details;

