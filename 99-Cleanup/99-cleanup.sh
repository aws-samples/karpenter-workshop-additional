kubectl delete nodepool.karpenter.sh default
kubectl delete ec2nodeclass.karpenter.k8s.aws default
helm -n monitoring uninstall prometheus
helm -n monitoring uninstall grafana
kubectl -n workshop delete deploy inflate
kubectl delete ns monitoring
kubectl delete ns workshop
helm uninstall karpenter --namespace karpenter
eksctl delete iamserviceaccount \
  --cluster eksworkshop-eksctl \
  --namespace karpenter \
  --name karpenter \
  --wait
aws cloudformation delete-stack --stack-name Karpenter-eksworkshop-eksctl
