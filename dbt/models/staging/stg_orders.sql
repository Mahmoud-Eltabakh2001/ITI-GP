SELECT DISTINCT
     order_id,
     customer_id,
     order_status,
     CASE
     WHEN order_delivered_customer_date IS NOT NULL THEN
      DATEDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)
     ELSE NULL
     END AS delay_in_days,
     order_purchase_timestamp
FROM {{ source('bronze_layer', 'RAW_ORDERS') }}