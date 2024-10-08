CREATE VIEW all_sales AS
    SELECT ss.card_id, ss.customer_id, ss.price, ss.product_id, ss.timestamp FROM spectrum.stage_sales ss where ss.year!=2002 and ss.month!=12
    UNION ALL
    SELECT * FROM public.sales ps
    WITH NO SCHEMA BINDING;
SELECT * FROM all_sales;