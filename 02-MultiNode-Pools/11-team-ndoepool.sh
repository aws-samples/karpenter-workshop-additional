mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> team-nodepool.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: team-nodepool
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
        eks-immersion-team: team-nodepool
    spec:
      nodeClassRef:
        name: team-nodepool
      requirements:
      - key: karpenter.k8s.aws/instance-category
        operator: In
        values:
        - t
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
---
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: team-nodepool
spec:
  amiFamily: AL2
  role: "KarpenterNodeRole-${CLUSTER_NAME}"
  securityGroupSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  subnetSelectorTerms:
  - tags:
      alpha.eksctl.io/cluster-name: $CLUSTER_NAME
  tags:
    intent: apps
    managed-by: karpenter
EoF

kubectl apply -f team-nodepool.yaml
sleep 5
kubectl get nodepools.karpenter.sh
