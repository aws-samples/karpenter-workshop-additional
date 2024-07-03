echo "shink 20 to 10 replicas"
kubectl scale deployment -n workshop inflate --replicas 10
echo "watch nodes being cordoned"
echo "eks-node-viewer --node-selector "eks-immersion-team" --resources cpu,memory --extra-labels=topology.kubernetes.io/zone"