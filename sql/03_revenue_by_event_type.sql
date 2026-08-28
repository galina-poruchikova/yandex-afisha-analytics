-- Распределение заказов и выручки по типам мероприятий
-- Анализ выполнен только для заказов в рублях

SELECT
    event_type_main,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    AVG(revenue) AS avg_revenue_per_order,
    COUNT(DISTINCT event_name_code) AS total_event_name,
    AVG(tickets_count) AS avg_tickets,
    SUM(revenue) / SUM(tickets_count) AS avg_ticket_revenue,
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
LEFT JOIN afisha.events USING (event_id)
WHERE currency_code = 'rub'
GROUP BY event_type_main
ORDER BY total_orders DESC;
