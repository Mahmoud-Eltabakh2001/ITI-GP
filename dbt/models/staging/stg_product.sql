SELECT DISTINCT
       p.product_id,p.product_category_name,pt.product_category_name_english,
       p.product_name_lenght,p.product_description_lenght,p.product_photos_qty,
       p.product_weight_g,p.product_length_cm,p.product_height_cm,p.product_width_cm
FROM {{ source('bronze_layer', 'RAW_PRODUCTS') }} p 
LEFT JOIN {{ source('bronze_layer', 'RAW_PRODUCT_CATEGORY_NAME_TRANSLATION') }} pt
ON p.product_category_name= pt.product_category_name