WITH distinct_payment AS (
    SELECT DISTINCT
        payment_type
    FROM {{ ref('stg_order_payments') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY payment_type) AS ID,
    payment_type
FROM distinct_payment