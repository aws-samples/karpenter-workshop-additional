export POD=$(kubectl get pods -n workshop -o name | cut -d/ -f2 | tail -n1)
kubectl describe pod $POD -n workshop
kubectl -n workshop exec $POD -- cat /data/out.txt

kubectl get pv
