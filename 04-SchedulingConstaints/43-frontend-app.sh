cd ~/environment/karpenter
cat <<EoF> podaffinity-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: workshop
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: backend
            topologyKey: topology.kubernetes.io/zone
      terminationGracePeriodSeconds: 0
      containers:
        - name: frontend
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              cpu: 1
      nodeSelector:
        eks-immersion-team: my-team
EoF

kubectl apply -f podaffinity-deploy.yaml

echo "should see pods in same zone as backend"