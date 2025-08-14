WITH distinct_status AS (
    SELECT DISTINCT
        order_status
    FROM {{ ref('stg_orders') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY order_status) AS ID,
    order_status
FROM distinct_status
