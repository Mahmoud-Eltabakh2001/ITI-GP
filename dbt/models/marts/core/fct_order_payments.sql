SELECT 
    ROW_NUMBER() OVER (ORDER BY op.order_id, op.payment_sequential) AS ID,  -- surrogate key
    op.order_id,
    op.payment_sequential,
    pt.id AS payment_type_key,
    op.payment_installments,
    op.payment_value
FROM {{ ref('stg_order_payments') }} op
JOIN {{ ref('dim_payment_type') }} pt 
    ON op.payment_type = pt.payment_type

