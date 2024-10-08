DROP VIEW IF EXISTS daily_sales_revenue;
create view daily_sales_revenue as 
select sum(price) as daily_sales_revenue, trunc(timestamp) as day 
from sales where price !=''
group by trunc(timestamp) order by trunc(timestamp);