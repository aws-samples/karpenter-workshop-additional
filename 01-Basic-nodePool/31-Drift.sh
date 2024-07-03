kubectl get nodepool default && kubectl get ec2nodeclass default  2>/dev/null || echo "Not found"
#setup "old" ami
export AMI_OLD=$(aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.23/amazon-linux-2/recommended/image_id --region $AWS_REGION --query "Parameter.Value" --output text)
echo 1.23=$AMI_OLD

