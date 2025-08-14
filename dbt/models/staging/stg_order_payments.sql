SELECT DISTINCT
     order_id,
     payment_sequential,
     payment_type,
     payment_installments,
     payment_value
FROM {{ source('bronze_layer', 'RAW_ORDER_PAYMENTS') }}