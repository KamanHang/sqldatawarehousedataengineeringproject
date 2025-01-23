-- Purpose: 
	-- The purpose of this SQL Script is to bulk insert data from csv files stored locally.

CREATE OR REPLACE PROCEDURE bronze.load_bonze()
LANGUAGE plpgsql
AS $$
BEGIN
	TRUNCATE TABLE bronze.crm_cust_info;
	COPY bronze.crm_cust_info FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER;
	-- SELECT count(*) FROM bronze.crm_cust_info;

	TRUNCATE TABLE bronze.crm_prd_info;
	COPY bronze.crm_prd_info FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER;
	-- SELECT count(*) FROM bronze.crm_prd_info;


	TRUNCATE TABLE bronze.crm_sales_details;
	COPY bronze.crm_sales_details FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER;
	-- SELECT count(*) FROM bronze.crm_sales_details;

	-- ERP Data Load 

	TRUNCATE TABLE bronze.erp_loc_a101;
	COPY bronze.erp_loc_a101 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/LOC_A101.csv' DELIMITER ',' CSV HEADER;

	TRUNCATE TABLE bronze.erp_cust_az12;
	COPY bronze.erp_cust_az12 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/CUST_AZ12.csv' DELIMITER ',' CSV HEADER;

	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	COPY bronze.erp_px_cat_g1v2 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/PX_CAT_G1V2.csv' DELIMITER ',' CSV HEADER;
END;
$$;
