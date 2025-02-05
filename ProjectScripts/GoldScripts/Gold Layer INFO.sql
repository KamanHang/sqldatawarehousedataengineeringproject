
-- SELECT
-- 	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- This Surrogate Key which works as primary for Dimension Table
-- 	crm_cust.cst_id AS customer_id,
-- 	crm_cust.cst_key AS customer_number,
-- 	crm_cust.cst_firstname AS customer_firstname,
-- 	crm_cust.cst_lastname AS customer_lastname,
-- 	erp_cust.bdate AS birthdate,
-- 	erp_loc.cntry AS country,
-- 	crm_cust.cst_marital_status AS marital_status,
-- 	CASE
-- 		WHEN crm_cust.cst_gndr != 'n/a' THEN crm_cust.cst_gndr -- CRM_CUST_INFO.cst_gndr is the MASTER source (Data Integration)
-- 		ELSE COALESCE(erp_cust.gen,'n/a')
-- 	END AS gender,
-- 	crm_cust.cst_create_date AS create_date
-- FROM silver.crm_cust_info crm_cust
-- LEFT JOIN silver.erp_cust_az12 erp_cust 
-- ON crm_cust.cst_key = erp_cust.cid -- Joining 
-- LEFT JOIN silver.erp_loc_a101 erp_loc
-- ON crm_cust.cst_key = erp_loc.cid;



-- Here is the thing if the data has start date and end date that means it is historical data 
-- but if end date is missing or it is null then it is called current data
-- We are doing our analysis in current data rather than historical data

-- SELECT 
-- ROW_NUMBER() OVER (ORDER BY crm_product.prd_start_dt, crm_product.prd_key) AS product_key, -- SURROGATE KEY
-- crm_product.prd_id AS product_id, 
-- crm_product.prd_key AS product_number, 
-- crm_product.prd_nm AS product_name, 
-- crm_product.cat_id AS category_id,
-- erp_product.cat AS category,
-- erp_product.subcat AS subcategory,
-- erp_product.maintenance,
-- crm_product.prd_cost AS product_cost, 
-- crm_product.prd_line AS product_line, 
-- crm_product.prd_start_dt AS product_start_date
-- FROM silver.crm_prd_info crm_product
-- LEFT JOIN silver.erp_px_cat_g1v2 erp_product
-- ON crm_product.cat_id = erp_product.id
-- WHERE prd_end_dt IS NULL-- To filter out the current data

-- SELECT * FROM silver.erp_px_cat_g1v2;


SELECT 
crm_sales.sls_ord_num AS order_number,
dim_prod.product_key, -- Surrogate Key from product
dim_cust.customer_key, -- Surrogate Key from customer
crm_sales.sls_order_dt AS order_date,
crm_sales.sls_ship_dt AS shipping_date,
crm_sales.sls_due_dt AS due_date,
crm_sales.sls_sales AS sales_amount,
crm_sales.sls_quantity AS quantity,
crm_sales.sls_price AS price
FROM silver.crm_sales_details AS crm_sales
LEFT JOIN gold.dim_products AS dim_prod
ON crm_sales.sls_prd_key = dim_prod.product_number
LEFT JOIN gold.dim_customers AS dim_cust
ON crm_sales.sls_cust_id = dim_cust.customer_id;
;

-- A "data lookup" is the process of retrieving specific information from a database or structured data set 
-- by searching for it using a particular key or identifier in this case SURROGATE KEYS












