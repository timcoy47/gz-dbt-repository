SELECT date_trunc(CAST(c.date_date AS DATE), 'month') as month
FROM {{ ref("stg_gz_raw_data__raw_gz_adwords") }} c
LIMIT 10;
