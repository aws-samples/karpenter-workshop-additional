kubectl delete deployment inflate -n workshop
kubectl delete nodepools.karpenter.sh default
kubectl delete ec2nodeclasses.karpenter.k8s.aws default
kubectl delete pvc ebs-claim -n workshop
kubectl delete sc mysql-gp2
eksctl delete addon --cluster $CLUSTER_NAME --name aws-ebs-csi-driver