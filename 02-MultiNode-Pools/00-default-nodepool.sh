mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat << EOF > karpenter_multi_nodepool_node_class.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  template:
    metadata:
      labels:
        eks-immersion-team: default
    spec:
      nodeClassRef:
        name: default
      requirements: 
        - key: "karpenter.k8s.aws/instance-category"
          operator: In
          values: ["c", "m", "r"]
        - key: "kubernetes.io/arch"
          operator: In
          values: ["amd64"]
        - key: "karpenter.sh/capacity-type" # If not included, the webhook for the AWS cloud provider will default to on-demand
          operator: In
          values: ["on-demand"]      
      kubelet:
        cpuCFSQuota: true                         
  disruption:
    consolidateAfter: 30s
    consolidationPolicy: WhenEmpty
    expireAfter: Never
  limits:
      cpu: "10"
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

kubectl -f karpenter_multi_nodepool_node_class.yaml create

echo "look on eks-node-viewer - see t* node"
echo "used this node pool as it has higher weight value - 2 (default is 0)"
