with union_tables as (
    SELECT *
    FROM {{ ref('stg_gz_raw_data__raw_gz_adwords') }}
    UNION ALL 
    SELECT *
    FROM {{ ref('stg_gz_raw_data__raw_gz_criteo') }}
    UNION ALL 
    SELECT *
    FROM {{ ref('stg_gz_raw_data__raw_gz_facebook') }}
)


select date_date
    , sum(ads_cost) as ads_cost
    , sum(impression) as impression
    , sum(click) as click
from union_tables
group by date_date