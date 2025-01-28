SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	 ELSE 'n/a'
END cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	 ELSE 'n/a'
END cst_gndr,
cst_create_date
FROM(
SELECT
		*
		FROM (
			SELECT 
			*,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as row_num
			FROM bronze.crm_cust_info
		)
		WHERE row_num = 1
) ;