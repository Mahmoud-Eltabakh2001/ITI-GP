SELECT DISTINCT
     oi.order_id,
     oi.order_item_id,
     oi.product_id,
     oi.seller_id,
     s.seller_zip_code_prefix,
     s.seller_city,
     oi.shipping_limit_date as shipping_date,
     oi.price,
     oi.freight_value as freight
FROM {{ source('bronze_layer', 'RAW_ORDER_ITEMS') }} oi
JOIN {{ source('bronze_layer', 'RAW_SELLERS') }} s 
ON oi.seller_id=s.seller_id