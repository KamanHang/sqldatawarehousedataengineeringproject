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


