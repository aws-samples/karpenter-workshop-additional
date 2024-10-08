accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
aws s3 ls $accid-$reg-datalake-raw/reviews/public/reviews/ | grep csv > /dev/null
if [[ $? -eq 0 ]];then
echo "PASSED: DynamoDB Load"
else
echo "FAILED: DynamoDB Load"
fi
aws s3 ls s3://$accid-$reg-datalake-raw/Product/ | grep year > /dev/null
if [[ $? -eq 0 ]];then
echo "PASSED: Firehose test"
else
echo "FAILED: Firehose test"
fi