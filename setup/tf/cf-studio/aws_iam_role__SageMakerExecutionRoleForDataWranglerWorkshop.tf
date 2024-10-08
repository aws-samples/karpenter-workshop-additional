##START,aws_iam_role
resource "aws_iam_role" "SageMakerExecutionRoleForDataWranglerWorkshop" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "sagemaker.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonSageMakerCanvasAIServicesAccess", "arn:aws:iam::aws:policy/AmazonSageMakerCanvasFullAccess", "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"]
  max_session_duration  = 3600
  name                  = "SageMakerExecutionRoleForDataWranglerWorkshop"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "SageMakerExecutionRoleForDataWranglerWorkshopPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
        }, {
        Action   = ["kms:DescribeKey", "kms:GenerateDataKey", "kms:Decrypt"]
        Effect   = "Allow"
        Resource = format("arn:aws:kms:%s:%s:key/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
      }]
      Version = "2012-10-17"
    })
  }
}
