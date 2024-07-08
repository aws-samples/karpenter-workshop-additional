cd ~/environment/karpenter
cat << EOF > custom_ami_node_class.yaml
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: custom
spec:
  amiFamily: Ubuntu
  role: "KarpenterNodeRole-${CLUSTER_NAME}"
  securityGroupSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  subnetSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  tags:
    ami-type: ubuntu
    intent: apps
    managed-by: karpenter


EOF
kubectl -f custom_ami_node_class.yaml create

cd ~/environment/karpenter
cat << EOF > custom_karpenter_nodepool.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: custom
spec:
  disruption:
    consolidateAfter: 30s
    consolidationPolicy: WhenEmpty
    expireAfter: Never
  limits:
    cpu: "50"
  template:
    metadata:
      labels:
        eks-immersion-team: default
    spec:
      nodeClassRef:
        name: custom
      requirements:
      - key: node.kubernetes.io/instance-type
        operator: In
        values:
        - m5.large
        - m5.xlarge
      - key: kubernetes.io/arch
        operator: In
        values:
        - amd64
      - key: kubernetes.io/os
        operator: In
        values:
        - linux
      - key: karpenter.sh/capacity-type
        operator: In
        values:
        - on-demand
EOF
kubectl -f custom_karpenter_nodepool.yaml create

