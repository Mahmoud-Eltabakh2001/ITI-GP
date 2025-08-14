WITH base_orders AS (
    select 
            o.order_id,
            os.id as order_status_key,
            g.ID as customer_zip_code_key,
            d.datekey as order_date_key,
            t.TimeKey as order_time_key,
            c.customer_id,
            o.delay_in_days
            
    from {{ ref('stg_orders') }} o
    join {{ ref('dim_order_status') }} os 
    on o.order_status = os.order_status
    join {{ ref('stg_customer') }} c
    on o.customer_id = c.customer_id
    join {{ ref('dim_geolocation') }} g
    on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix 
    and c.customer_city = g.geolocation_city
    join {{ ref('dim_date') }} d
    on cast(o.order_purchase_timestamp as date) = d.full_date
    join {{ ref('dim_time') }} t
    on TO_CHAR(o.order_purchase_timestamp, 'HH24:MI') =t.time
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY order_id) AS ID,  -- ✅ Surrogate Key
    *
FROM base_orders
