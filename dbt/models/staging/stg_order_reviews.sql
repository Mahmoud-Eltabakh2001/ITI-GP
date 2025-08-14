SELECT DISTINCT
     review_id,
     order_id,
     review_score,
     review_comment_title as review_title,
     review_comment_message as review_message,
     review_creation_date,
     CASE
     WHEN review_creation_date IS NOT NULL and review_answer_timestamp IS NOT NULL THEN
     DATEDIFF(DAY, review_creation_date, review_answer_timestamp)
     ELSE NULL
     END AS response_in_days
FROM {{ source('bronze_layer', 'RAW_ORDER_REVIEWS') }}