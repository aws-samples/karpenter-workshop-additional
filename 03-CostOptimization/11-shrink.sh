echo "scale inflate from 9 to 4 - should shrink form 2 nodes to 1"
kubectl scale deployment -n workshop inflate --replicas 4
echo "look on eks-node-viewer - now just 1 Karpenter node:
