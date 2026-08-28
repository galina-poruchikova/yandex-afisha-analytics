-- Топ-7 регионов по выручке
-- Анализ выполнен только для заказов в рублях

SELECT
    region_name,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(tickets_count) AS total_tickets,
    SUM(revenue) / SUM(tickets_count) AS one_ticket_cost
FROM afisha.purchases
LEFT JOIN afisha.events USING (event_id)
LEFT JOIN afisha.city USING (city_id)
LEFT JOIN afisha.regions USING (region_id)
WHERE currency_code = 'rub'
GROUP BY region_name
ORDER BY total_revenue DESC
LIMIT 7;
