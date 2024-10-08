aws glue start-crawler --name raw-data-crawler
sleep 120
aws glue start-job-run --job-name stage_sales_data
aws glue start-job-run --job-name stage_customer_data
sleep 240
aws glue start-crawler --name stage-data-crawler