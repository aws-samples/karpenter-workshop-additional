aws ssm get-parameters --name AuroraEndpoint AthenaSpillBucketName LambdaExecutionRoleArn AuroraSecurityGroup DBSubnet1 DBSubnet2 --query 'Parameters[].[Name,Value]'

# create labmda app
larn=$(aws lambda create-function --function-name auroraDBsource \



aws athena create-data-catalog \
              --name auroraDBsource \
              --type LAMBDA \
              --description "aurora Federated" \
              --parameters function=$larn