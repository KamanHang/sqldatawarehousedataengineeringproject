
-- Handling Duplicate Records 
SELECT cst_id, count(*)
FROM (
		SELECT
		*
		FROM (
			SELECT 
			*,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as row_num
			FROM bronze.crm_cust_info
		)
		WHERE row_num = 1
)
GROUP BY cst_id;

-- Check for unwanted Spaces
SELECT TRIM(cst_firstname) AS cst_firstname, TRIM(cst_lastname) AS cst_lastname 
FROM bronze.crm_cust_info;

-- DATA Standardization and Consistency
SELECT DISTINCT cst_gndr FROM bronze.crm_cust_info;
-- For data consistency I have replaced the gender M as Male and F as Female using CASE WHEN statement
SELECT DISTINCT prd_line FROM bronze.crm_prd_info;

-- Checking if End Date is Earlier than the Start Date
SELECT * FROM bronze.crm_prd_info WHERE prd_end_dt < prd_start_dt;

SELECT 
prd_id,
prd_key, 
prd_nm, 
prd_start_dt, 
LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)AS prd_start_Date_test,
prd_end_dt 
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509');



-- Checking if product key and customer id from sales details table can be connected and doesn't have any issue with product and customer table
SELECT 
* 
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);

SELECT 
* 
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);


-- Converting integer date from sales details table to actual date data type
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LENGTH(CAST(sls_order_dt as VARCHAR)) != 8 THEN NULL
	 ELSE CAST(CAST(sls_order_dt as VARCHAR) as DATE)
END AS sls_order_dt
FROM bronze.crm_sales_details;


-- Checking the ORDER of all the dates
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
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Check if sls_sales follows the business rule or not which is sales = quantity * price
SELECT 
sls_sales , sls_quantity , sls_price
FROM bronze.crm_sales_details 
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL 
OR sls_sales < 0 OR sls_quantity < 0 OR sls_price < 0
ORDER BY  sls_sales , sls_quantity , sls_price;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- We cannot just directly transofrm the data by own
-- But communicate with source system expert for decision
-- However We have set few rules as of now for data accuracy

-- If Sales is negative, null, or zero derive it using quantity and price
-- If Price is zero or null, calculate it using sales and quantity
-- If Price is negative, convert it to a positive value
-----------------------------------------------------------------
-----------------------------------------------------------------
SELECT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales <=0 
	OR sls_quantity <=0 
	OR sls_price <=0 
	OR sls_sales IS NULL 
	OR sls_quantity IS NULL
	OR sls_price IS NULL
	OR sls_sales != sls_quantity * sls_price
ORDER BY sls_sales, sls_quantity, sls_price;
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
---- Clearning UNWANTED Characters from the customer id----------
SELECT DISTINCT 
cid,
SUBSTR(cid,1,3),
CASE 
	WHEN cid LIKE ('NAS%') THEN SUBSTR(cid,4,LENGTH(cid)) -- Removing NAS from the Customer ID which is the first 3 character 
	ELSE cid
END AS new_cid
FROM bronze.erp_cust_az12;

SELECT 
CASE
	WHEN bdate > CURRENT_TIMESTAMP THEN NULL
	ELSE bdate
END AS bdate
FROM bronze.erp_cust_az12 WHERE bdate > CURRENT_TIMESTAMP ;

-- Keep only 3 distinct values Male Female and n/a
-- All the empty spaces, null values are replaced with not available n/a
SELECT DISTINCT gen,
CASE 
	WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	ELSE 'n/a'
END AS gen_new
FROM bronze.erp_cust_az12;






