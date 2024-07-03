mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> spot.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: Never
  limits:
    cpu: 1000
    memory: 1000Gi
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
      - key: kubernetes.io/arch
        operator: In
        values:
        - amd64
      - key: karpenter.sh/capacity-type
        operator: In
        values:
        - spot
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

kubectl apply -f spot.yaml

echo "deploy app"

cd ~/environment/karpenter
cat <<EOF > spot-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 2
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      nodeSelector:
        intent: apps
        karpenter.sh/capacity-type: spot
      containers:
      - image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
        name: inflate
        resources:
          requests:
            cpu: "1"
            memory: 256M
      nodeSelector:
        eks-immersion-team: my-team    
EOF
kubectl apply -f spot-deploy.yaml

