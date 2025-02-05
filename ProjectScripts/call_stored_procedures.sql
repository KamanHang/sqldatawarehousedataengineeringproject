-- This Script is used to call the STORED Procedures from BRONZE and SILVER Layer

CALL bronze.load_bronze(); -- This Stored Procedure loads the raw data from data sources to the BRONZE LAYER


CALL silver.load_silver(); -- This Stored Procedure cleans the data from BRONZE Layer and loads to SILVER Layer