
kubectl -n workshop delete deployment inflate
kubectl delete nodepool.karpenter.sh weight-nodepool
kubectl delete ec2nodeclass.karpenter.k8s.aws weight-nodepool
