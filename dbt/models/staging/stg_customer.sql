SELECT DISTINCT
    customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM {{ source('bronze_layer', 'RAW_CUSTOMERS') }}