-- Распределение выручки и заказов по типу устройства
-- Анализ выполнен только для заказов в рублях

SELECT
    device_type_canonical,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    AVG(revenue) AS avg_revenue_per_order,
    ROUND(
        SUM(revenue)::numeric
        / (
            SELECT SUM(revenue)
            FROM afisha.purchases
            WHERE currency_code = 'rub'
        )::numeric,
        3
    ) AS revenue_share
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY device_type_canonical
ORDER BY revenue_share DESC;
