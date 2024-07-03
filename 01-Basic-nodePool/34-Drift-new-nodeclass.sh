export AMI_NEW=$(aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.24/amazon-linux-2/recommended/image_id --region $AWS_REGION --query "Parameter.Value" --output text)
echo 1.24=$AMI_NEW
cd ~/environment/karpenter
cat << EOF > newnode_class.yaml
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: newnode
spec:
  amiFamily: AL2
  amiSelectorTerms:
    - id: $AMI_NEW
  role: karpenterNodeRole-$CLUSTER_NAME
  securityGroupSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  subnetSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  tags:
    intent: apps
    managed-by: karpenter

EOF
kubectl -f newnode_class.yaml create
echo "Now do:"
echo "kubectl edit nodepool default"
echo "Change: oldnode to newnode"