mkdir ~/environment/karpenter
cd ~/environment/karpenter
cat <<EoF> basic-rightsizing.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 8
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

kubectl apply -f basic-rightsizing.yaml
echo "in eks-node-viewer"
echo "you can also see there are 7 pods that landed one node which is c6a.2xlarge instance (8vCPU and 16GIB)"
echo " and rest one pod landed on another one node c6a.large instance (2vCPU and 4GIB)."
