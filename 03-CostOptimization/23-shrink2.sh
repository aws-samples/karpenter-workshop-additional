kubectl scale deployment -n workshop inflate --replicas 4
echo "kubectl -n karpenter logs -l app.kubernetes.io/name=karpenter"
echo "shrink to 2 nodes:
