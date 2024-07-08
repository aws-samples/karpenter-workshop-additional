mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> multinode.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: Never
  limits:
    cpu: 1k
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
      - key: karpenter.k8s.aws/instance-cpu
        operator: Lt
        values:
        - "5"
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

kubectl apply -f multinode.yaml

echo "20 replicas:"

cd ~/environment/karpenter
cat <<EoF> multinode-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 20
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      terminationGracePeriodSeconds: 0
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              memory: 1Gi
              cpu: 1
      nodeSelector:
        eks-immersion-team: my-team
EoF

kubectl apply -f multinode-deploy.yaml
sleep 10
"echo shoudl see 34 pods - 7 Karpenter nodes"
