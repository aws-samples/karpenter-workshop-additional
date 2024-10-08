unload ('select * from daily_sales_revenue')
to 's3://007532665219-eu-west-1-datalake-analytics/daily_sales_revenue/'
FORMAT AS parquet
PARALLEL TRUE
iam_role 'arn:aws:iam::007532665219:role/RedshiftExecutionRole';
