cd ~/environment/karpenter
kubectl delete -f basic-deploy.yaml
sleep 5
cd ~/environment/karpenter
kubectl delete -f default_karpenter_NodePool.yaml
kubectl delete -f default_node_class.yaml
