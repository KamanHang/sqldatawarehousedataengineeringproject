CREATE VIEW gold.dim_products AS
SELECT 
ROW_NUMBER() OVER (ORDER BY crm_product.prd_start_dt, crm_product.prd_key) AS product_key, -- SURROGATE KEY
crm_product.prd_id AS product_id, 
crm_product.prd_key AS product_number, 
crm_product.prd_nm AS product_name, 
crm_product.cat_id AS category_id,
erp_product.cat AS category,
erp_product.subcat AS subcategory,
erp_product.maintenance,
crm_product.prd_cost AS product_cost, 
crm_product.prd_line AS product_line, 
crm_product.prd_start_dt AS product_start_date
FROM silver.crm_prd_info crm_product
LEFT JOIN silver.erp_px_cat_g1v2 erp_product
ON crm_product.cat_id = erp_product.id
WHERE prd_end_dt IS NULL