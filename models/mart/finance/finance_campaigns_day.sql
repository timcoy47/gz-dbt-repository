select *
    , operational_margin - ads_cost as ads_margin
    , ads_cost
    , impression
    , click
    , nb_transactions
    , revenue
    , average_basket
    , average_basket_bis
    , margin
    , operational_margin
    , purchase_cost
    , shipping_fee
    , log_cost
    , ship_cost
    , quantity
    ads_margin
from {{ ref('int_campaigns_day') }} c
inner join {{ ref('finance_days') }} f
on c.date_date = f.date_date