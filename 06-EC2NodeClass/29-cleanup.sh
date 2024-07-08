cd ~/environment/karpenter
kubectl delete -f basic-deploy.yaml
sleep 5
kubectl delete -f custom_karpenter_nodepool.yaml
kubectl delete -f custom_ami_node_class.yaml
