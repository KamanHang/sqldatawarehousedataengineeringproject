-- Below Script is used for loading the data into the Silver layer's erp_loc_a101 table
-- This scipt also involves few data cleaning tasks such as: 
	--1 Removing unecessary character '-' from cid column
	--2 Data Standardization of cntry column   
INSERT INTO silver.erp_loc_a101(
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


