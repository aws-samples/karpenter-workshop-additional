cd ~/environment/karpenter
cat <<EoF> taint-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
  namespace: workshop
spec:
  replicas: 3
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
      tolerations:
      - key: "systemnodes"
        operator: "Exists"
        effect: "NoSchedule"
      nodeSelector:
        eks-immersion-team: my-team
EoF

kubectl apply -f taint-deploy.yaml
