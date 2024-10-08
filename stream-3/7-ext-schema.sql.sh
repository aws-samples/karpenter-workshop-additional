accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
cat <<EOF >7-ext-schema.sql
create external schema spectrum 
from data catalog 
database 'stage'
iam_role 'arn:aws:iam::$accid:role/RedshiftExecutionRole';
EOF