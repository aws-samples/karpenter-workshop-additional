export CLUSTER_NAME=eksworkshop-eksctl
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
AWS_REGION=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/region 2> /dev/null)
export LAB_CLUSTER_ID=eksworkshop-eksctl
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
echo "export LAB_CLUSTER_ID=eksworkshop-eksctl" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
eksctl utils associate-iam-oidc-provider \
      --region ${AWS_REGION} \
      --cluster ${LAB_CLUSTER_ID} \
      --approve
curl -o iam-policy.json https://raw.githubusercontent.com/aws-containers/eks-app-mesh-polyglot-demo/master/workshop/aws_lbc_iam_policy.json
aws iam create-policy \
      --policy-name AWSLoadBalancerControllerIAMPolicy \
      --policy-document file://iam-policy.json
eksctl create iamserviceaccount \
--cluster=${LAB_CLUSTER_ID} \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--region ${AWS_REGION} \
--approve
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${LAB_CLUSTER_ID} --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller



