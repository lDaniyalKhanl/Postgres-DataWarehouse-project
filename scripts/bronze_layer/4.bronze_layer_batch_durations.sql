SELECT
    batch_id,
    start_time,
    end_time,
    duration_seconds,
    rows_loaded
FROM bronze.etl_load_log
WHERE table_name = 'BRONZE_BATCH'
ORDER BY start_time DESC;
