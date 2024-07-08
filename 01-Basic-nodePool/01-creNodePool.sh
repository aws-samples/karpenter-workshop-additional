export CLUSTER_NAME=$(eksctl get clusters -o json | jq -r '.[0].Name')
mkdir ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> basic.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  disruption:
    consolidateAfter: 30s
    consolidationPolicy: WhenEmpty
    expireAfter: Never
  limits:
    cpu: "10"
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
        values: ["c", "m", "r"]
      - key: kubernetes.io/arch
        operator: In
        values: ["amd64"]
      - key: karpenter.sh/capacity-type # If not included, the webhook for the AWS cloud provider will default to on-demand
        operator: In
        values: ["on-demand"]
      - key: kubernetes.io/os
        operator: In
        values: ["linux"]

---
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2
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
EoF

kubectl apply -f basic.yaml
