-- Below SQL Script will load the Customer data from bronze layer to silver layer ERP product table  
-- Below Script will insert data along with the required data cleaning and transformation logic
-----------------------------------------------------------------
--  Here are the Data Erros that has been cleaned and inserted
-- 1 cid column data contains unwanted NAS at the begining of Customer ID
-- 2 birth date is more than the current date MAKE THAT AS NULL value
-- 3 Gender Column consist empty, null and unstandardized values that needs to be taken care of

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
