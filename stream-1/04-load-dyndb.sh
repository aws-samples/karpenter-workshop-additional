accid=$(aws sts get-caller-identity --query Account --output text)
reg=$(aws configure get region --output text)
curl https://ws-assets-prod-iad-r-cmh-8d6e9c21a4dec77d.s3.us-east-2.amazonaws.com/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_1/data/Product-1.json -o ./Product1.json
curl https://ws-assets-prod-iad-r-cmh-8d6e9c21a4dec77d.s3.us-east-2.amazonaws.com/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_1/data/Product-2.json -o ./Product2.json
sleep 5
echo "load dyndb"
aws dynamodb batch-write-item --request-items file://Product1.json
aws dynamodb batch-write-item --request-items file://Product2.json
echo "sleep 90s then check s3 bucket"
sleep 90
aws s3 ls s3://$accid-$reg-datalake-raw | grep Product