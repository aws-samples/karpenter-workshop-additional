accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
cat <<EOF >2.sql
copy sales from 's3://$accid-$reg-datalake-stage/sales/year=2021/month=12/'
iam_role 'arn:aws:iam::$accid:role/RedshiftExecutionRole'
format as parquet;
EOF