CREATE TABLE IF NOT EXISTS bronze.etl_load_log (
    log_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    batch_id UUID NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ,
    duration_seconds NUMERIC(12,2),
    rows_loaded BIGINT,
    status VARCHAR(20) NOT NULL,
    error_message TEXT
);
