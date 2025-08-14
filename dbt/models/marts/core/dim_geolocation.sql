WITH base AS (
SELECT DISTINCT
      COALESCE(
        c.customer_zip_code_prefix,
        s.seller_zip_code_prefix
      ) AS geolocation_zip_code_prefix,
      COALESCE(
        c.customer_city,
        s.seller_city
      ) AS geolocation_city,
      COALESCE(
        c.customer_state,
        s.seller_state
      ) AS geolocation_state,
FROM stg_customer c  
FULL OUTER JOIN stg_seller s
ON c.customer_zip_code_prefix = s.seller_zip_code_prefix
)

SELECT
  ROW_NUMBER() OVER (ORDER BY geolocation_zip_code_prefix) AS ID,
  geolocation_zip_code_prefix,
  geolocation_city,
  geolocation_state
FROM base
