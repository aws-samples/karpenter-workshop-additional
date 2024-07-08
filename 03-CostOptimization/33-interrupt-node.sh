export NODE_NAME=$(kubectl get nodes -l "eks-immersion-team" -o name | cut -d/ -f2) 
echo $NODE_NAME
export NODE_ID=$(aws ec2 describe-instances --query "Reservations[].Instances[?PrivateDnsName == '${NODE_NAME}'].InstanceId" --output text)
echo $NODE_ID
./ec2-spot-interrupter --instance-ids "$NODE_ID"
sleep 10
kubectl -n karpenter logs -l app.kubernetes.io/name=karpenter
