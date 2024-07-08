cd ~/environment/karpenter
cat <<EoF> team-workload.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 1
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      containers:
      - name: inflate
        image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
        resources:
          requests:
            cpu: 1
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node.kubernetes.io/instance-type
                operator: In
                values:
                - t3.micro
EoF
kubectl apply -f team-workload.yaml
echo "as this require t3.micro and the default nodepool can't meet this - the team nodepool is used"