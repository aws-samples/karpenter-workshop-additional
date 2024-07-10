export CLUSTER_NAME=eksworkshop-eksctl
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
AWS_REGION=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/region 2> /dev/null)
#aws iam attach-role-policy \
#--role-name my-worker-node-role \
#--policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy
#aws eks create-addon --cluster-name eksworkshop-eksctl --addon-name amazon-cloudwatch-observability
helm repo add aws-observability https://aws-observability.github.io/helm-charts
helm repo update aws-observability
helm install --wait --create-namespace --namespace amazon-cloudwatch amazon-cloudwatch-observability aws-observability/amazon-cloudwatch-observability --set clusterName=eksworkshop-eksctl --set region=$AWS_REGION
