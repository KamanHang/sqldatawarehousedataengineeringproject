-- Purpose and learnings: 
-- The purpose of this SQL Script is to bulk insert data from CSV files stored locally.
-- I have also calculated the duration of ETL to check the load period and batch load period as well 
-- Used TIMESTAMP data type for storing date and time values


CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    load_duration INTERVAL;

	batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
    batch_load_duration INTERVAL;
BEGIN
	batch_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '----------------------------------------------';

    -- CRM Data Load
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE 'Loading Data into CRM Tables';
    RAISE NOTICE '----------------------------------------------';

    -- Record Start Time
    start_time := CURRENT_TIMESTAMP;
    -- Truncate and Load Data into CRM Tables
    RAISE NOTICE 'Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE 'Inserting Data into Table: bronze.crm_cust_info';
    COPY bronze.crm_cust_info FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
    -- Record End Time and Load Duration
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

	-- Record Start Time
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE 'Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE 'Inserting Data into Table: bronze.crm_prd_info';
    COPY bronze.crm_prd_info FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
	-- Record End Time and Load Duration	
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;
	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

	-- Record Start Time
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE 'Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    RAISE NOTICE 'Inserting Data into Table: bronze.crm_sales_details';
    COPY bronze.crm_sales_details FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
	-- Record End Time and Load Duration	
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;
	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

    -- ERP Data Load
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE 'Loading Data into ERP Tables';
    RAISE NOTICE '----------------------------------------------';

	-- Record Start Time
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE 'Truncating Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE 'Inserting Data into Table: bronze.erp_loc_a101';
    COPY bronze.erp_loc_a101 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/LOC_A101.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
	-- Record End Time and Load Duration	
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;
	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

	-- Record Start Time
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE 'Truncating Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE 'Inserting Data into Table: bronze.erp_cust_az12';
    COPY bronze.erp_cust_az12 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/CUST_AZ12.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
	-- Record End Time and Load Duration	
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;
	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

	-- Record Start Time
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE 'Truncating Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE 'Inserting Data into Table: bronze.erp_px_cat_g1v2';
    COPY bronze.erp_px_cat_g1v2 FROM 'E:/sqldatawarehousedataengineeringproject/Datasets/source_erp/PX_CAT_G1V2.csv' DELIMITER ',' CSV HEADER;
    RAISE NOTICE 'Inserting Data COMPLETED';
	-- Record End Time and Load Duration	
    end_time := CURRENT_TIMESTAMP;
    load_duration := end_time - start_time;
    RAISE NOTICE 'Load Duration: % seconds', load_duration;

	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';
	RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE '----------------------------------------------';

	batch_end_time := CURRENT_TIMESTAMP;
	batch_load_duration := batch_end_time - batch_start_time;
	RAISE NOTICE 'LOADING BRONZE LAYER IS COMPLETED SUCCESSFULLY!!!!!!';
	RAISE NOTICE 'Batch Load Duration: % seconds', batch_load_duration;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '----------------------------------------------';
        RAISE NOTICE 'Error FOUND!';
        RAISE NOTICE 'Error MESSAGE: %', SQLERRM;
        RAISE NOTICE '----------------------------------------------';
        RAISE EXCEPTION 'Procedure failed: %', SQLERRM;



END;
$$;
