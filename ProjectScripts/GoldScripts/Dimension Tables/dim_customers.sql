-- For creating customer dimension table
-- I performed
	-- Data Integration
	-- To bring data from different sources for complete and accurate data for better BI or Analysis
-- For Gold layer I have created VIEW


CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- This Surrogate Key which works as primary for Dimension Table
	crm_cust.cst_id AS customer_id,
	crm_cust.cst_key AS customer_number,
	crm_cust.cst_firstname AS customer_firstname,
	crm_cust.cst_lastname AS customer_lastname,
	erp_cust.bdate AS birthdate,
	erp_loc.cntry AS country,
	crm_cust.cst_marital_status AS marital_status,
	CASE
		WHEN crm_cust.cst_gndr != 'n/a' THEN crm_cust.cst_gndr -- CRM_CUST_INFO.cst_gndr is the MASTER source (Data Integration)
		ELSE COALESCE(erp_cust.gen,'n/a')
	END AS gender,
	crm_cust.cst_create_date AS create_date
FROM silver.crm_cust_info crm_cust
LEFT JOIN silver.erp_cust_az12 erp_cust 
ON crm_cust.cst_key = erp_cust.cid -- Joining CRM - ERP Customer Tables
LEFT JOIN silver.erp_loc_a101 erp_loc -- Joining CRM Customer table with ERP location table
ON crm_cust.cst_key = erp_loc.cid;