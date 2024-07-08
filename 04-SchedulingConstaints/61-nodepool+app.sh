export AWS_REGION=$(aws configure get region)
export AZ1="$AWS_REGION"a
export AZ2="$AWS_REGION"b
mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> pdb-nodepool.yaml
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
    cpu: "20"
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
          values: ["c", "m"]
        - key: karpenter.k8s.aws/instance-cpu
          operator: Lt
          values: ["3"]
        - key: topology.kubernetes.io/zone
          operator: In
          values: ["${AZ2}"]
        - key: "kubernetes.io/arch"
          operator: In
          values: ["amd64"]
        - key: "karpenter.sh/capacity-type" # If not included, the webhook for the AWS cloud provider will default to on-demand
          operator: In
          values: ["on-demand"]
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

kubectl apply -f pdb-nodepool.yaml
echo "Deploy Pod Disruption Budget"
echo "will block node termination if evicting the pod would reduce the number of available pods below 4."
echo "for app: inflate"
cd ~/environment/karpenter
cat <<EoF> pdb.yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: inflate-pdb
  namespace: workshop
spec:
  minAvailable: 4
  selector:
    matchLabels:
      app: inflate
EoF

kubectl apply -f pdb.yaml   

cd ~/environment/karpenter
cat <<EoF> pdb-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 6
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
      - name: app
        image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
        resources:
          requests:
            memory: 1Gi
            cpu: 1
      nodeSelector:
        eks-immersion-team: my-team
EoF
echo "Deploy app inflate with 6 replicas"
kubectl apply -f pdb-deploy.yaml



