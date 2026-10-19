
SELECT
    batch_id,
    table_name,
    rows_loaded,
    duration_seconds,
    status,
    start_time,
    end_time
FROM bronze.etl_load_log
ORDER BY log_id DESC;

