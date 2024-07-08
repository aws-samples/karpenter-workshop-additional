mkdir ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> ratiosplit.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: on-demand
spec:
  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: Never
  limits:
    cpu: "100"
  template:
    metadata:
      labels:
        eks-immersion-team: my-team
    spec:
      nodeClassRef:
        name: default
      requirements:
      - key: karpenter.k8s.aws/instance-category
        operator: In
        values:
        - c
        - m
        - r
      - key: capacity-spread
        operator: In
        values:
        - "1"
      - key: kubernetes.io/arch
        operator: In
        values:
        - amd64
      - key: karpenter.sh/capacity-type
        operator: In
        values:
        - on-demand
      - key: kubernetes.io/os
        operator: In
        values:
        - linux
---
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: spot
spec:
  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: Never
  limits:
    cpu: "100"
  template:
    metadata:
      labels:
        eks-immersion-team: my-team
    spec:
      nodeClassRef:
        name: default
      requirements:
      - key: karpenter.k8s.aws/instance-category
        operator: In
        values:
        - c
        - m
        - r
      - key: capacity-spread
        operator: In
        values:
        - "2"
        - "3"
        - "4"
        - "5"
      - key: kubernetes.io/arch
        operator: In
        values:
        - amd64
      - key: karpenter.sh/capacity-type
        operator: In
        values:
        - spot
      - key: kubernetes.io/os
        operator: In
        values:
        - linux
---
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
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
    eks-immersion-team: my-team
EoF

kubectl apply -f ratiosplit.yaml
