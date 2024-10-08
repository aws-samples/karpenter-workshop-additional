accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
cat <<EOF >9-unload.sql
unload ('select * from daily_sales_revenue')
to 's3://$accid-$reg-datalake-analytics/daily_sales_revenue/'
FORMAT AS parquet
PARALLEL TRUE
iam_role 'arn:aws:iam::$accid:role/RedshiftExecutionRole';
EOF
./run-query.sh 9-unload.sql
sleep 5
aws s3 ls $accid-$reg-datalake-analytics/daily_sales_revenue/ | grep parquet