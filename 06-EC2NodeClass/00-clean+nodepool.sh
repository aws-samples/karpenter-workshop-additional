kubectl delete deployment -n workshop inflate
kubectl delete nodepool default
kubectl delete ec2nodeclass default
mkdir -p ~/environment/karpenter
cd ~/environment/karpenter
cat <<EOF> default_karpenter_NodePool.yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  disruption:
    consolidateAfter: 30s
    consolidationPolicy: WhenEmpty
    expireAfter: Never
  limits:
    cpu: "10"
  template:
    metadata:
        labels:
         eks-immersion-team: my-team
    spec:
      nodeClassRef:
        name: default
      requirements:
      - key: karpenter.k8s.aws/instance-category
        operator: In
        values: ["c", "m", "r"]
      - key: kubernetes.io/arch
        operator: In
        values: ["amd64"]
      - key: karpenter.sh/capacity-type # If not included, the webhook for the AWS cloud provider will default to on-demand
        operator: In
        values: ["on-demand"]
      - key: kubernetes.io/os
        operator: In
        values: ["linux"]
EOF
kubectl apply -f default_karpenter_NodePool.yaml
