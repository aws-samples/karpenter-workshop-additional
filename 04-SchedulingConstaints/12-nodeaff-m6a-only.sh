cd ~/environment/karpenter
cat <<EoF> constraint-deploy.yaml
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
      affinity: 
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: "node.kubernetes.io/instance-type"
                  operator: "In"
                  values: ["m6a.xlarge"]
      terminationGracePeriodSeconds: 0
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              cpu: 1
      nodeSelector:
        eks-immersion-team: my-team
EoF

kubectl apply -f constraint-deploy.yaml
