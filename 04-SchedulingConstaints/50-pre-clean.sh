kubectl delete deployment -n workshop inflate
kubectl delete deployment -n workshop backend
kubectl delete deployment -n workshop frontend
kubectl delete nodepools.karpenter.sh default
kubectl delete ec2nodeclasses.karpenter.k8s.aws default
