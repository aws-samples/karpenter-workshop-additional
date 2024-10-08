copy sales from 's3://007532665219-eu-west-1-datalake-stage/sales/year=2021/month=12/'
iam_role 'arn:aws:iam::007532665219:role/RedshiftExecutionRole'
format as parquet;
