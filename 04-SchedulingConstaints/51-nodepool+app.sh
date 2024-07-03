mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> pv.yaml
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
      # Requirements that constrain the parameters of provisioned nodes.
      # These requirements are combined with pod.spec.affinity.nodeAffinity rules.
      # Operators { In, NotIn } are supported to enable including or excluding values
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

kubectl apply -f pv.yaml

export AWS_REGION=$(aws configure get region)

export AZ1="$AWS_REGION"a
export AZ2="$AWS_REGION"b

cd ~/environment/karpenter
cat <<EoF> pv-deploy.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mysql-gp2
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
allowedTopologies:
- matchLabelExpressions:
  - key: topology.ebs.csi.aws.com/zone
    values: ["$AZ1","$AZ2"]
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-claim
  namespace: workshop
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: mysql-gp2
  resources:
    requests:
      storage: 4Gi
---
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
      terminationGracePeriodSeconds: 0
      containers:
      - name: app
        image: centos
        command: ["/bin/sh"]
        args: ["-c", "while true; do echo hello workshop users! Nice to meet you for $(( $RANDOM % 1000 + 1 )) time!>> /data/out.txt; sleep 200; done"]
        volumeMounts:
        - name: persistent-storage
          mountPath: /data
        resources:
          requests:
            cpu: 1
      volumes:
      - name: persistent-storage
        persistentVolumeClaim:
          claimName: ebs-claim
      nodeSelector:
        eks-immersion-team: my-team
EoF

kubectl apply -f pv-deploy.yaml

