export CLUSTER_NAME=$(eksctl get clusters -o json | jq -r '.[0].Name')
cat <<EoF> np1.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default1
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
        values: ["c"]
      - key: kubernetes.io/arch
        operator: In
        values: ["amd64"]
      - key: karpenter.sh/capacity-type # If not included, the webhook for the AWS cloud provider will default to on-demand
        operator: In
        values: ["on-demand"]
      - key: kubernetes.io/os
        operator: In
        values: ["linux"]

EoF

cat <<EoF> np2.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default2
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
        values: ["m"]
      - key: kubernetes.io/arch
        operator: In
        values: ["amd64"]
      - key: karpenter.sh/capacity-type # If not included, the webhook for the AWS cloud provider will default to on-demand
        operator: In
        values: ["on-demand"]
      - key: kubernetes.io/os
        operator: In
        values: ["linux"]
EoF


cat <<EoF> ec2nc.yaml
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



cat <<EoF> inflate.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 0
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      terminationGracePeriodSeconds: 0
      topologySpreadConstraints:
         - maxSkew: 1
           topologyKey: karpenter.sh/nodepool
           whenUnsatisfiable: DoNotSchedule
           labelSelector:
             matchLabels:
               app: inflate
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              cpu: 1
      nodeSelector:
        eks-immersion-team: my-team
EoF

