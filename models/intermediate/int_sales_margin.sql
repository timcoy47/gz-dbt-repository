-- models/intermediate/int_sales_margin.sql
WITH sales_data AS (
    SELECT 
        s.date_date,
        s.orders_id,
        s.pdt_id AS product_id,
        s.revenue,
        s.quantity,
        p.purchSE_PRICE
    FROM {{ ref('stg_gz_raw_data__raw_gz_sales') }} AS s
    LEFT JOIN {{ ref('stg_gz_raw_data__raw_gz_product') }} AS p
    ON s.pdt_id = p.products_id
)
SELECT
    date_date,
    orders_id,
    product_id,
    revenue,
    quantity,
    purchSE_PRICE,
    CAST(quantity AS INT64) * CAST(purchSE_PRICE AS NUMERIC) AS purchase_cost,
    revenue - (CAST(quantity AS INT64) * CAST(purchSE_PRICE AS NUMERIC)) AS margin
FROM sales_data