kubectl -n workshop delete deployment inflate
kubectl delete nodepools.karpenter.sh team-nodepool
kubectl delete ec2nodeclass.karpenter.k8s.aws team-nodepool
kubectl -n karpenter logs -l app.kubernetes.io/name=karpenter | grep controller.node.termination
