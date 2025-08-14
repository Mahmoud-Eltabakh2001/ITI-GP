SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS ID,
    *
FROM {{ ref('stg_product') }}