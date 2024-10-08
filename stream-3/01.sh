accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
rsarn=$(aws secretsmanager list-secrets --query 'SecretList[*].ARN' | jq -r '.[]' | grep RedshiftSecret)
clid=$(aws redshift describe-clusters --query 'Clusters[*].ClusterIdentifier' --output text | grep mdawarehouse-)
#
ret=$(aws redshift-data execute-statement \
    --region $reg \
    --secret $rsarn \
    --cluster-identifier $clid \
    --sql file://1.sql \
    --database dev )
sid=$(echo $ret | jq -r '.Id')
r1=$(aws redshift-data describe-statement --id $sid --query Status --output text)
echo $r1
#aws redshift-data get-statement-result --id $sid