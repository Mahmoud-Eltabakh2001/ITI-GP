SELECT DISTINCT *
FROM {{ source('bronze_layer', 'RAW_SELLERS') }} 
