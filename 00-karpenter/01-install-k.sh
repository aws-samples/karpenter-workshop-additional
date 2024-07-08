#
export TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
export CLUSTER_NAME=$(eksctl get clusters -o json | jq -r '.[0].Name')
export AWS_REGION=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
export CLUSTER_ENDPOINT="$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.endpoint" --output text)"
export AZ1="$AWS_REGION"a
export AZ2="$AWS_REGION"b
echo Cluster Name:$CLUSTER_NAME AWS Region:$AWS_REGION Account ID:$AWS_ACCOUNT_ID Cluster Endpoint:$CLUSTER_ENDPOINT AZ1:$AZ1 AZ2:$AZ2
#
TEMPOUT=$(mktemp)
curl -fsSL https://karpenter.sh/docs/getting-started/getting-started-with-karpenter/cloudformation.yaml  > $TEMPOUT \
&& aws cloudformation deploy \
  --stack-name "Karpenter-${CLUSTER_NAME}" \
  --template-file "${TEMPOUT}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides "ClusterName=${CLUSTER_NAME}"
#
eksctl create iamidentitymapping \
  --username system:node:{{EC2PrivateDNSName}} \
  --cluster "${CLUSTER_NAME}" \
  --arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/KarpenterNodeRole-${CLUSTER_NAME}" \
  --group system:bootstrappers \
  --group system:nodes
#
kubectl describe configmap -n kube-system aws-auth
#
eksctl utils associate-iam-oidc-provider --cluster ${CLUSTER_NAME} --approve
#
eksctl create iamserviceaccount \
  --cluster "${CLUSTER_NAME}" --name karpenter --namespace karpenter \
  --role-name "${CLUSTER_NAME}-karpenter" \
  --attach-policy-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:policy/KarpenterControllerPolicy-${CLUSTER_NAME}" \
  --role-only \
  --approve
export KARPENTER_IAM_ROLE_ARN="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${CLUSTER_NAME}-karpenter"
#
eksctl get iamserviceaccount --cluster $CLUSTER_NAME --namespace karpenter
#
aws iam create-service-linked-role --aws-service-name spot.amazonaws.com || true
#
KARPENTER_VERSION=$(curl -sL "https://api.github.com/repos/aws/karpenter/releases/latest" | jq -r ".tag_name") 
export KARPENTER_VERSION_STR="${KARPENTER_VERSION/v}"
echo "Karpenter's Latest release version: $KARPENTER_VERSION_STR"
#
echo Your Karpenter version is: $KARPENTER_VERSION_STR
docker logout public.ecr.aws
helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter --version ${KARPENTER_VERSION_STR} --namespace karpenter --create-namespace \
  --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=${KARPENTER_IAM_ROLE_ARN} \
  --set settings.clusterName=${CLUSTER_NAME} \
  --set settings.clusterEndpoint=${CLUSTER_ENDPOINT} \
  --set settings.interruptionQueue=${CLUSTER_NAME} \
  --set settings.featureGates.drift=true \
  --set settings.featureGates.SpotToSpotConsolidation=true \
  --wait
#
helm list -n karpenter
#
kubectl get pods --namespace karpenter
#
kubectl get deployment -n karpenter
#


