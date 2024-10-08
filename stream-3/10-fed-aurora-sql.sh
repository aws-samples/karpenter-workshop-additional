accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
auroraendp=$(aws ssm get-parameters --name AuroraEndpoint --query 'Parameters[].[Value]' --output text)
aurorasecret=$(aws ssm get-parameters --name AuroraSecretARN --query 'Parameters[].[Value]' --output text)
cat <<EOF >10-fed-aurora.sql
CREATE EXTERNAL SCHEMA auroradb
FROM POSTGRES DATABASE 'mdacluster'
URI '${auroraendp}'
IAM_ROLE 'arn:aws:iam::$accid:role/RedshiftExecutionRole'
PORT 3306 
SECRET_ARN '${aurorasecret}';
EOF