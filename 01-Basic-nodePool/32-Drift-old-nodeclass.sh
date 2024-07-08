cd ~/environment/karpenter
cat << EOF > oldnode_class.yaml
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: oldnode
spec:
  amiFamily: AL2
  amiSelectorTerms:
    - id: $AMI_OLD
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

kubectl -f oldnode_class.yaml create
echo "Now do:"
echo "kubectl edit nodepool default"
echo "Change: default to oldnode"

