
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



