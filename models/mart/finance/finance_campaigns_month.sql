with
    union_tables as (
        select *
        from {{ ref("stg_gz_raw_data__raw_gz_adwords") }}
        union all
        select *
        from {{ ref("stg_gz_raw_data__raw_gz_criteo") }}
        union all
        select *
        from {{ ref("stg_gz_raw_data__raw_gz_facebook") }}
    ),

    combined_data as (
        select
            extract(year from cast(c.date_date as timestamp)) as year,
            extract(month from cast(c.date_date as timestamp)) as month,
            sum(c.ads_cost) as ads_cost,
            sum(c.impression) as impression,
            sum(c.click) as click,
            sum(f.nb_transactions) as nb_transactions,
            sum(f.revenue) as revenue,
            avg(f.average_basket) as average_basket,
            avg(f.average_basket_bis) as average_basket_bis,
            sum(f.margin) as margin,
            sum(f.operational_margin) as operational_margin,
            sum(f.operational_margin) - sum(c.ads_cost) as ads_margin,
            sum(f.purchase_cost) as purchase_cost,
            sum(f.shipping_fee) as shipping_fee,
            sum(f.log_cost) as log_cost,
            sum(f.ship_cost) as ship_cost,
            sum(f.quantity) as quantity
        from union_tables c
        inner join
            {{ ref("finance_days") }} f
            on cast(c.date_date as timestamp) = cast(f.date_date as timestamp)
        group by
            extract(year from cast(c.date_date as timestamp)),
            extract(month from cast(c.date_date as timestamp))
    )

select
    concat(cast(year as string), '-', lpad(cast(month as string), 2, '0')) as month,  -- Formats the year and month as YYYY-MM
    ads_cost,
    impression,
    click,
    nb_transactions,
    revenue,
    average_basket,
    average_basket_bis,
    margin,
    operational_margin,
    ads_margin,
    purchase_cost,
    shipping_fee,
    log_cost,
    ship_cost,
    quantity
from combined_data
order by month