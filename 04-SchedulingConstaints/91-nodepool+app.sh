mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> multi-arch.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  template:
    metadata:
      labels:
        eks-immersion-team: my-team
    spec:
      nodeClassRef:
        name: default
      requirements:
        - key: "karpenter.k8s.aws/instance-category"
          operator: In
          values: ["c", "m", "r"]
        - key: "kubernetes.io/arch"
          operator: In
          values: ["amd64", "arm64"]
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
EoF

kubectl apply -f multi-arch.yaml

mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> inflate.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 10
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: kubernetes.io/arch
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: inflate
      terminationGracePeriodSeconds: 0
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              memory: 1Gi
              cpu: 1
EoF

kubectl apply -f inflate.yaml

echo "should see g node type shortly...."