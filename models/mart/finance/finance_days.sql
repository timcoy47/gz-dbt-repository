select
    date_date,
    count(orders_id) as nb_transactions,
    round(sum(revenue), 0) as revenue,
    round(avg(revenue), 1) as average_basket,
    round(sum(revenue) / count(orders_id), 1) as average_basket_bis,
    round(sum(margin), 0) as margin,
    round(sum(operational_margin), 0) as operational_margin,
    round(sum(purchase_cost), 0) as purchase_cost,
    round(sum(shipping_fee), 0) as shipping_fee,
    round(sum(log_cost), 0) as log_cost,
    round(sum(ship_cost), 0) as ship_cost,
    sum(quantity) as quantity
from {{ ref("int_orders_operational") }}
group by date_date
order by date_date desc
