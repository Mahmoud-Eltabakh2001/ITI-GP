WITH fact_reviews_base AS (

    select 
        ors.review_id,
        ors.order_id,
        rc.id as review_comment_id,
        d.datekey as review_creation_date_key,
        ors.review_score,
        ors.response_in_days
        
    from {{ ref('stg_order_reviews') }} as ors
    join {{ ref('review_comments') }} rc
        on ors.review_title = rc.review_title 
        and ors.review_message = rc.review_message
    join {{ ref('dim_date') }} d
        on ors.review_creation_date = d.full_date 

)

SELECT 
    ROW_NUMBER() OVER (ORDER BY review_id) AS ID,  -- Surrogate Key
    *
FROM fact_reviews_base
