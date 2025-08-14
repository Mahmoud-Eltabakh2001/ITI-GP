WITH distinct_reviews AS(
     SELECT DISTINCT
            review_title,
            review_message   
     FROM {{ ref('stg_order_reviews') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY 1) AS ID,
    review_title,
    review_message
FROM distinct_reviews