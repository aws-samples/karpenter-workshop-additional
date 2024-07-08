cd ~/environment/karpenter
cat <<EoF> capacity-deploy.yaml
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
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: capacity-spread
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: inflate
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

kubectl apply -f capacity-deploy.yaml
echo "5 replicas - should see 1x on deman 4x spot"  
echo "scale to 10 - see 2x on-demand  8x spot"