if [[ $1 == "" ]]; then
    echo "must pass sql filename as a parameter"
    exit
fi
accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
rsarn=$(aws secretsmanager list-secrets --query 'SecretList[*].ARN' | jq -r '.[]' | grep RedshiftSecret)
clid=$(aws redshift describe-clusters --query 'Clusters[*].ClusterIdentifier' --output text | grep mdawarehouse-)
#
ret=$(aws redshift-data execute-statement \
    --region $reg \
    --secret $rsarn \
    --cluster-identifier $clid \
    --sql file://$1 \
    --database dev)
sid=$(echo $ret | jq -r '.Id')
echo "5s wait for running ...."
cat $1
echo ""
echo "aws redshift-data describe-statement --id $sid --query Status --output text"
sleep 5
r1=$(aws redshift-data describe-statement --id $sid --query Status --output text)
echo $r1
if [[ $r1 == "FAILED" ]]; then
    echo "sql failed"
    exit
fi

echo "aws redshift-data get-statement-result --id $sid"
r2=$(aws redshift-data get-statement-result --id $sid)
echo $r2 | grep ResourceNotFoundException >/dev/null
if [[ $? -eq 0 ]]; then
    echo "no sql output"
else
    echo "sql output total rows:"
    echo $r2 | jq .TotalNumRows
fi
