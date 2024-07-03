kubectl delete deployment -n workshop inflate
kubectl delete nodepool.karpenter.sh/default
kubectl delete ec2nodeclass.karpenter.k8s.aws/default
