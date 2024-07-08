kubectl get ec2nodeclass
kubectl get nodepool
cd ~/environment/karpenter
cat <<EOF > basic-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 5
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
              cpu: 1
EOF

kubectl apply -f basic-deploy.yaml

