WITH all_dates AS (
    SELECT MIN(order_purchase_timestamp) AS min_date,
           MAX(order_purchase_timestamp) AS max_date
    FROM {{ ref('stg_orders') }}
    
    UNION ALL

    SELECT MIN(shipping_date), MAX(shipping_date)
    FROM {{ ref('stg_order_items') }}
    
    UNION ALL

    SELECT MIN(review_creation_date), MAX(review_creation_date)
    FROM {{ ref('stg_order_reviews') }}
),

date_bounds AS (
    SELECT 
        MIN(min_date) AS start_date,
        MAX(max_date) AS end_date
    FROM all_dates
),

numbers AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1 AS i
    FROM TABLE(GENERATOR(ROWCOUNT => 10000))
),

date_spine AS (
    SELECT 
        DATEADD(day, i, start_date) AS date_day
    FROM numbers, date_bounds
    QUALIFY date_day <= end_date
)

SELECT 
    TO_CHAR(date_day, 'YYYYMMDD')::NUMBER AS DateKey,
    DATE_TRUNC('DAY', date_day) AS full_date,
    EXTRACT(year FROM date_day) AS year,
    EXTRACT(month FROM date_day) AS month,
    EXTRACT(day FROM date_day) AS day,
    TRIM(TO_CHAR(date_day, 'Dy')) AS day_name,
    TRIM(TO_CHAR(date_day, 'Mon')) AS month_name,
    EXTRACT(quarter FROM date_day) AS quarter,
    CASE 
        WHEN EXTRACT(dow FROM date_day) IN (6, 0) THEN TRUE 
        ELSE FALSE 
    END AS is_weekend
FROM date_spine
ORDER BY date_day

