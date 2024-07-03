kubectl get ec2nodeclass
kubectl get nodepool
KARP_NODE=$(kubectl get nodes -l=karpenter.sh/registered=true -o=jsonpath='{.items[*].metadata.name}') &&  KARP_NODE_AMI=$(aws ec2 describe-instances --filters "Name=tag:Name, Values=$KARP_NODE"| jq '.Reservations[].Instances[].ImageId') && echo "Your Karpenter Node $KARP_NODE is Using a CustomAMI $KARP_NODE_AMI"
