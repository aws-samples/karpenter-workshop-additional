echo "PW"
kubectl -n monitoring get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo "LB URL - may need multiple minutes"
kubectl -n monitoring get svc grafana -ojson|jq '.status.loadBalancer.ingress[0].hostname'|tr -d '"'
echo "scale to 30 replicas"
kubectl -n workshop scale deployment inflate --replicas=30
