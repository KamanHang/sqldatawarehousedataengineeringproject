-- Below Script is for loading all the cleaned data from bronze layer to silver layer

CREATE OR REPLACE PROCEDURE silver.load_silver()
LANGUAGE plpgsql
AS $$
BEGIN
	RAISE NOTICE '>> Truncate TABLE: silver.crm_cust_info';
	TRUNCATE silver.crm_cust_info;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_cust_info';
	INSERT into silver.crm_cust_info(
		cst_id, 
		cst_key, 
		cst_firstname, 
		cst_lastname, 
		cst_marital_status, 
		cst_gndr, 
		cst_create_date
	)
	SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married' -- Data Standardization of Marital Status colum
		 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' -- Data Standardization of Marital Status colum
		 ELSE 'n/a'
	END cst_marital_status,
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' -- Data Standardization of customer gender colum
		 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'  -- Data Standardization of customer gender colum
		 ELSE 'n/a'
	END cst_gndr,
	cst_create_date
	FROM(
	SELECT
			*
			FROM (
				SELECT 
				*,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as row_num -- this sub query provides only the latest record to reduce the duplicate rows
				FROM bronze.crm_cust_info
			)
			WHERE row_num = 1
	) ;INSERT into silver.crm_cust_info(
		cst_id, 
		cst_key, 
		cst_firstname, 
		cst_lastname, 
		cst_marital_status, 
		cst_gndr, 
		cst_create_date
	)
	SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married' -- Data Standardization of Marital Status colum
		 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' -- Data Standardization of Marital Status colum
		 ELSE 'n/a'
	END cst_marital_status,
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' -- Data Standardization of customer gender colum
		 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'  -- Data Standardization of customer gender colum
		 ELSE 'n/a'
	END cst_gndr,
	cst_create_date
	FROM(
	SELECT
			*
			FROM (
				SELECT 
				*,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as row_num -- this sub query provides only the latest record to reduce the duplicate rows
				FROM bronze.crm_cust_info
			)
			WHERE row_num = 1
	) ;

	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_cust_info COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';


	RAISE NOTICE '>> Truncate TABLE: silver.crm_prd_info';
	TRUNCATE silver.crm_prd_info;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_prd_info';
	INSERT into silver.crm_prd_info(
		prd_id,  
		cat_id, -- Will be used For joining erp_px_cat_g1v2 table
		prd_key, -- Will be used for joining sales_details table
		prd_nm,
		prd_cost, -- Replacing Null Values with Zero
		prd_line,
		prd_start_dt,
		prd_end_dt -- Fixed the date order issue
	)
	SELECT 
	prd_id,  
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id, -- Will be used For joining erp_px_cat_g1v2 table
	SUBSTRING(prd_key,7,LENGTH(prd_key)) AS prd_key, -- Will be used for joining sales_details table
	prd_nm,
	COALESCE(prd_cost, 0) AS prd_cost, -- Replacing Null Values with Zero
	CASE UPPER(TRIM(prd_line)) 
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales'
		WHEN 'T' THEN 'Touring'
		ELSE 'n/a'
	END prd_line, -- Got the Values from Source System Expert
	prd_start_dt,
	LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt -- Fixed the date order issue
	FROM bronze.crm_prd_info;
	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_prd_info COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';


	RAISE NOTICE '>> Truncate TABLE: silver.crm_sales_details';
	TRUNCATE silver.crm_sales_details;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_sales_details';

	INSERT INTO silver.crm_sales_details (
 	sls_ord_num,
    sls_prd_key,
    sls_cust_id ,
    sls_order_dt ,
    sls_ship_dt ,
    sls_due_dt ,
    sls_sales ,
    sls_quantity ,
    sls_price
	)
	SELECT  
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE WHEN sls_order_dt = 0 OR LENGTH(CAST(sls_order_dt as VARCHAR)) != 8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt as VARCHAR) as DATE)
	END AS sls_order_dt,
	
	CASE WHEN sls_ship_dt = 0 OR LENGTH(CAST(sls_ship_dt as VARCHAR)) != 8 THEN NULL
		 ELSE CAST(CAST(sls_ship_dt as VARCHAR) as DATE)
	END AS sls_ship_dt,
	
	CASE WHEN sls_due_dt = 0 OR LENGTH(CAST(sls_due_dt as VARCHAR)) != 8 THEN NULL
		 ELSE CAST(CAST(sls_due_dt as VARCHAR) as DATE)
	END AS sls_due_dt,
	CASE 
		WHEN sls_sales <=0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price)
		 	THEN sls_quantity * ABS(sls_price)
		 ELSE sls_sales
	END AS sls_sales,
	sls_quantity,
	CASE 
		WHEN sls_price <=0 OR sls_price IS NULL
		 	THEN sls_sales / NULLIF(sls_quantity,0)
		ELSE sls_price
	END AS sls_price
	FROM bronze.crm_sales_details;
	
	RAISE NOTICE '>> Insert Data into TABLE: silver.crm_sales_details COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';

	 
	RAISE NOTICE '>> Truncate TABLE: silver.erp_cust_az12';
	TRUNCATE silver.erp_cust_az12;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_cust_az12';
	INSERT INTO silver.erp_cust_az12
	(
	cid,
	bdate,
	gen
	)
	SELECT 
	CASE
		WHEN cid LIKE 'NAS%' THEN SUBSTR(cid,4,LENGTH(cid)) 
		ELSE cid
	END AS cid,
	CASE
		WHEN bdate > CURRENT_TIMESTAMP THEN NULL
		ELSE bdate
	END AS bdate,
	CASE 
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female' -- REMOVING EMPTY SPACES and Standardizing F with Female
		WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male' -- REMOVING EMPTY SPACES and Standardizing M with Male
		ELSE 'n/a' -- Besides Male and Female if the value is empty or null keeping it not available n/a
	END AS gen
	FROM bronze.erp_cust_az12; 
	
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_cust_az12 COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';




	RAISE NOTICE '>> Truncate TABLE: silver.erp_loc_a101';
	TRUNCATE silver.erp_loc_a101;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_loc_a101';
	INSERT INTO silver.erp_loc_a101
	(
 	cid,
 	cntry
	)
	SELECT 
	REPLACE(cid,'-','') AS cid, -- Removing unwanted character '-' from cid column
	CASE
		WHEN TRIM(cntry) IN ('DE', 'Germany') THEN 'Germany' -- Standardizing Country Code Data into actual Country Name
		WHEN TRIM(cntry) IN ('US', 'United States') THEN 'United States' -- Standardizing Country Code Data into actual Country Name
		WHEN TRIM(cntry) IN ('USA', 'United States') THEN 'United States' -- Standardizing Country Code Data into actual Country Name
		WHEN TRIM(cntry) = '' OR TRIM(cntry) IS NULL THEN 'n/a' -- When value is empty or null 'n/a' is kept
		ELSE cntry
	END AS cntry
	FROM bronze.erp_loc_a101;
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_loc_a101 COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';



	RAISE NOTICE '>> Truncate TABLE: silver.erp_px_cat_g1v2';
	TRUNCATE silver.erp_px_cat_g1v2;
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_px_cat_g1v2';
	INSERT INTO silver.erp_px_cat_g1v2
	(
	id,
	cat,
	subcat,
	maintenance
	)
	SELECT 
	*
	FROM bronze.erp_px_cat_g1v2;
	RAISE NOTICE '>> Insert Data into TABLE: silver.erp_px_cat_g1v2 COMPLETED!!!';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';

	RAISE NOTICE '>>-------------------------------------------<<';
	RAISE NOTICE '>>-----!Silver Layer LOAD COMPLETE!---------------<<';
	RAISE NOTICE '>>-------------------------------------------<<';
END
$$;