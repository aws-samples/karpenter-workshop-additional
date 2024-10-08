CREATE EXTERNAL SCHEMA auroradb
FROM POSTGRES DATABASE 'mdacluster'
URI 'mdadb.chk4g8maydyw.eu-west-1.rds.amazonaws.com'
IAM_ROLE 'arn:aws:iam::007532665219:role/RedshiftExecutionRole'
PORT 3306 
SECRET_ARN 'arn:aws:secretsmanager:eu-west-1:007532665219:secret:AuroraSecret-znUvlE';
