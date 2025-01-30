-- Below SQL Script will load the product data from bronze layer to silver layer product info table  
-- Below Script will insert data along with the required data cleaning and transformation logic

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