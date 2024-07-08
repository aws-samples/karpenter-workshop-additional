export AWS_REGION=$(aws configure get region)
export AZ_1=$(aws ec2 describe-subnets --region $AWS_REGION  --filters Name=tag:alpha.eksctl.io/cluster-name,Values=eksworkshop-eksctl --query "Subnets[0].AvailabilityZone" --output text)
echo $AZ_1
cd ~/environment/karpenter
kubectl delete deployment -n workshop inflate
cat <<EoF> inflate.yaml
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
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              memory: 1Gi
              cpu: 1
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node.kubernetes.io/instance-type
                operator: In
                values:
                - c5.large
                - c6i.large
                - c7i.large
              - key: topology.kubernetes.io/zone
                operator: In
                values:
                - ${AZ_1}
EoF

kubectl apply -f inflate.yaml

