WITH fact_orders_base AS (

    select 
            oi.order_id,
            oi.order_item_id,
            p.ID as product_id,
            g.id as seller_zip_code,
            d.DateKey as shipping_date_key,
            t.TimeKey as shipping_time_key,
            s.seller_id,
            oi.price,
            oi.freight
            
    from {{ ref('stg_order_items') }} oi
    join {{ ref('dim_product') }} p 
    on oi.product_id = p.product_id
    join {{ ref('stg_seller') }} s 
    on oi.seller_id = s.seller_id 
    left join {{ ref('dim_geolocation') }} g
    on g.geolocation_zip_code_prefix = s.seller_zip_code_prefix 
    and g.geolocation_city = s.seller_city
    join {{ ref('dim_time') }} t
    on TO_CHAR(oi.shipping_date, 'HH24:MI') = t.time
    join {{ ref('dim_date') }} d 
    on cast(oi.shipping_date as date) = d.full_date

)

SELECT 
    ROW_NUMBER() OVER (ORDER BY order_id, order_item_id) AS ID, 
    *
FROM fact_orders_base
