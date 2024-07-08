helm uninstall --namespace monitoring grafana
helm uninstall --namespace monitoring prometheus
kubectl delete namespace monitoring
