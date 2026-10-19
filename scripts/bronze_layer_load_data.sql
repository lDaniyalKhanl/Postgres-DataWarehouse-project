
-- ============================================================
-- STORED PROCEDURE: bronze.load_bronze
-- PURPOSE:
--   Load all six Bronze tables from CSV files.
--   Track execution times, row counts, and errors.
--
-- LOAD TYPE:
--   Full Load (TRUNCATE + COPY)
-- ============================================================
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    -- ============================================
    -- BATCH VARIABLES
    -- ============================================
    v_batch_id UUID;
    v_batch_start TIMESTAMPTZ;
    v_batch_end TIMESTAMPTZ;
    v_batch_duration NUMERIC(12,2);
    -- ============================================
    -- TABLE VARIABLES
    -- ============================================
    v_start_time TIMESTAMPTZ;
    v_end_time TIMESTAMPTZ;
    v_load_duration NUMERIC(12,2);
    -- ============================================
    -- ROW COUNT VARIABLES
    -- ============================================
    v_rows_loaded BIGINT;
    v_total_rows BIGINT := 0;
    -- ============================================
    -- ERROR VARIABLES
    -- ============================================
    v_current_table TEXT;
    v_error_message TEXT;
    v_error_state TEXT;
BEGIN
    -- ============================================
    -- START BATCH
    -- ============================================
    v_batch_id := gen_random_uuid();
    v_batch_start := clock_timestamp();
    RAISE NOTICE '========================================';
    RAISE NOTICE 'STARTING BRONZE LAYER LOAD';
    RAISE NOTICE 'Batch ID: %', v_batch_id;
    RAISE NOTICE '========================================';
    -- ========================================================
    -- 1. CRM CUSTOMER INFORMATION
    -- ========================================================
    v_current_table := 'bronze.crm_cust_info';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.crm_cust_info
    FROM 'C:/DataWarehouse/datasets/source_crm/cust_info.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id,
        table_name,
        start_time,
        end_time,
        duration_seconds,
        rows_loaded,
        status
    )
    VALUES (
        v_batch_id,
        v_current_table,
        v_start_time,
        v_end_time,
        v_load_duration,
        v_rows_loaded,
        'SUCCESS'
    );
    -- ========================================================
    -- 2. CRM PRODUCT INFORMATION
    -- ========================================================
    v_current_table := 'bronze.crm_prd_info';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.crm_prd_info
    FROM 'C:/DataWarehouse/datasets/source_crm/prd_info.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id, table_name, start_time, end_time,
        duration_seconds, rows_loaded, status
    )
    VALUES (
        v_batch_id, v_current_table, v_start_time, v_end_time,
        v_load_duration, v_rows_loaded, 'SUCCESS'
    );
    -- ========================================================
    -- 3. CRM SALES DETAILS
    -- ========================================================
    v_current_table := 'bronze.crm_sales_details';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.crm_sales_details;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.crm_sales_details
    FROM 'C:/DataWarehouse/datasets/source_crm/sales_details.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id, table_name, start_time, end_time,
        duration_seconds, rows_loaded, status
    )
    VALUES (
        v_batch_id, v_current_table, v_start_time, v_end_time,
        v_load_duration, v_rows_loaded, 'SUCCESS'
    );
    -- ========================================================
    -- 4. ERP CUSTOMER INFORMATION
    -- ========================================================
    v_current_table := 'bronze.erp_cust_az12';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.erp_cust_az12
    FROM 'C:/DataWarehouse/datasets/source_erp/CUST_AZ12.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id, table_name, start_time, end_time,
        duration_seconds, rows_loaded, status
    )
    VALUES (
        v_batch_id, v_current_table, v_start_time, v_end_time,
        v_load_duration, v_rows_loaded, 'SUCCESS'
    );
    -- ========================================================
    -- 5. ERP LOCATION INFORMATION
    -- ========================================================
    v_current_table := 'bronze.erp_loc_a101';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.erp_loc_a101
    FROM 'C:/DataWarehouse/datasets/source_erp/LOC_A101.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id, table_name, start_time, end_time,
        duration_seconds, rows_loaded, status
    )
    VALUES (
        v_batch_id, v_current_table, v_start_time, v_end_time,
        v_load_duration, v_rows_loaded, 'SUCCESS'
    );
    -- ========================================================
    -- 6. ERP PRODUCT CATEGORY
    -- ========================================================
    v_current_table := 'bronze.erp_px_cat_g1v2';
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: %', v_current_table;
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> Loading Table: %', v_current_table;
    COPY bronze.erp_px_cat_g1v2
    FROM 'C:/DataWarehouse/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );
    GET DIAGNOSTICS v_rows_loaded = ROW_COUNT;
    v_end_time := clock_timestamp();
    v_load_duration := ROUND(
        EXTRACT(EPOCH FROM (v_end_time - v_start_time)),
2
    );
    v_total_rows := v_total_rows + v_rows_loaded;
    RAISE NOTICE '>> Rows Loaded: %', v_rows_loaded;
    RAISE NOTICE '>> Load Duration: % seconds', v_load_duration;
    INSERT INTO bronze.etl_load_log (
        batch_id, table_name, start_time, end_time,
        duration_seconds, rows_loaded, status
    )
    VALUES (
        v_batch_id, v_current_table, v_start_time, v_end_time,
        v_load_duration, v_rows_loaded, 'SUCCESS'
    );
    -- ========================================================
    -- BATCH COMPLETION
    -- ========================================================
    v_batch_end := clock_timestamp();
    v_batch_duration := ROUND(
        EXTRACT(EPOCH FROM (v_batch_end - v_batch_start)),
2
    );
    RAISE NOTICE '========================================';
    RAISE NOTICE 'BRONZE LAYER LOAD COMPLETED';
    RAISE NOTICE 'Total Rows Loaded: %', v_total_rows;
    RAISE NOTICE 'Total Batch Duration: % seconds', v_batch_duration;
    RAISE NOTICE '========================================';
    INSERT INTO bronze.etl_load_log (
        batch_id,
        table_name,
        start_time,
        end_time,
        duration_seconds,
        rows_loaded,
        status
    )
    VALUES (
        v_batch_id,
        'BRONZE_BATCH',
        v_batch_start,
        v_batch_end,
        v_batch_duration,
        v_total_rows,
        'SUCCESS'
    );
-- ============================================================
-- ERROR HANDLING
-- ============================================================
EXCEPTION
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS
            v_error_message = MESSAGE_TEXT,
            v_error_state = RETURNED_SQLSTATE;
        RAISE NOTICE '========================================';
        RAISE NOTICE 'ERROR DURING BRONZE LAYER LOAD';
        RAISE NOTICE 'Failed Table: %', v_current_table;
        RAISE NOTICE 'Error Message: %', v_error_message;
        RAISE NOTICE 'SQLSTATE: %', v_error_state;
        RAISE NOTICE '========================================';
        -- Rethrow the original error.
        -- This causes the failed transaction to roll back.
        RAISE;
END;
$$;

CALL bronze.load_bronze();
