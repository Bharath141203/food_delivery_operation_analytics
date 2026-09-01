create database food_analytics;
use food_analytics;
-- used to import data method --

-- total orders--
select count(*) as total_orders from food_analytics.cleaned_orders;

-- total revenue --
select sum(total_amount_inr) as total_revenue from food_analytics.cleaned_orders
where order_status= 'Delivered';

-- Average Delivery Time --
select avg(actual_delivery_mins) as avg_delivery_time
from food_analytics.cleaned_orders where order_status = "Delivered";

-- Delay Rate --
select round(sum(case when is_delayed ="yes" then 1 else 0 end) *100.0/count(*),
2) as delay_rate from food_analytics.cleaned_orders where order_status = "Delivered"; 

-- TOP 10 ITEMS BY REVENUE --
select item_name,sum(total_amount_inr) as revenue from food_analytics.cleaned_orders 
where order_status = "Delivered" group by item_name order by revenue desc limit 10;

-- DELAY RATE BY AREA --

SELECT delivery_area,count(*) AS total_orders,sum(
        case
            WHEN is_delayed = 'Yes' THEN 1 ELSE 0 END) AS delayed_orders,ROUND(
            SUM(case when is_delayed = 'Yes' THEN 1 ELSE 0 END ) * 100.0 / COUNT(*),2) AS delay_rate
FROM food_analytics.cleaned_orders
WHERE order_status = 'Delivered'
GROUP BY delivery_area ORDER BY delay_rate DESC;