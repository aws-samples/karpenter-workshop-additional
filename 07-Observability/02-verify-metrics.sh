kubectl run -i --tty --rm debug --image=alpine/curl --restart=Never -- wget -O - http://karpenter.karpenter.svc.cluster.local:8000/metrics
