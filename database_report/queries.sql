-- queries.sql
-- Example queries for analysis

-- 1. 商品別売上個数の多い順ランキング
SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity
FROM
    order_detail od
JOIN
    product p ON od.product_id = p.product_id
GROUP BY
    od.product_id
ORDER BY
    total_quantity DESC;

-- 2. 購入金額の多い顧客ランキング
SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
JOIN
    order_detail od ON o.order_id = od.order_id
JOIN
    product p ON od.product_id = p.product_id
GROUP BY
    c.customer_id
ORDER BY
    total_spent DESC;

-- 3. 注文数の多い国ランキング
SELECT
    c.country,
    COUNT(o.order_id) AS order_count
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY
    c.country
ORDER BY
    order_count DESC;