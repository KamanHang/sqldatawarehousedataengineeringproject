-- One of the interesting thing I learned while creating fact table is
-- A "data lookup" 
-- It is the process of retrieving specific information from a database or structured data set 
-- by searching for it using a particular key or identifier in this case SURROGATE KEYS

CREATE VIEW gold.fact_sales AS
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