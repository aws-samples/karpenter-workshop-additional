kubectl get nodes -l eks-immersion-team=my-team 

kubectl -n karpenter logs --tail=100 -l app.kubernetes.io/name=karpenter | grep -i drift  
sleep 5
kubectl get nodes -l eks-immersion-team=my-team 

kubectl -n karpenter logs --tail=100 -l app.kubernetes.io/name=karpenter | grep -i drift  