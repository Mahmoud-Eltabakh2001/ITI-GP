WITH hours AS (
    SELECT SEQ4() AS hour
    FROM TABLE(GENERATOR(ROWCOUNT => 24))
),
minutes AS (
    SELECT SEQ4() AS minute
    FROM TABLE(GENERATOR(ROWCOUNT => 60))
),
time_series AS (
    SELECT
        (hours.hour * 60 + minutes.minute) AS minute_of_day,
        hours.hour,
        minutes.minute
    FROM hours
    CROSS JOIN minutes
)

SELECT
    hour * 100 + minute AS TimeKey,                  -- Surrogate Key 
    LPAD(TO_VARCHAR(hour), 2, '0') || ':' || 
    LPAD(TO_VARCHAR(minute), 2, '0') AS time,        -- Formatted Time
    hour,
    minute,
    CASE
        WHEN hour < 12 THEN 'AM'
        ELSE 'PM'
    END AS am_pm,
    CASE
        WHEN hour BETWEEN 5 AND 11 THEN 'Morning'
        WHEN hour BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN hour BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS period_of_day
FROM time_series
ORDER BY minute_of_day
