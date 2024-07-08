kubectl -n karpenter logs -l app.kubernetes.io/name=karpenter
kubectl get nodes -l eks-immersion-team=my-team
kubectl get node -l eks-immersion-team=my-team -o json | jq -r '.items[0].metadata.labels'
