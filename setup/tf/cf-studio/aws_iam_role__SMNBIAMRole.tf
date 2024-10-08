##START,aws_iam_role
resource "aws_iam_role" "SMNBIAMRole" {
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
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"]
  max_session_duration  = 3600
  name                  = "SMNBIAMRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "logging"
    policy = jsonencode({
      Statement = [{
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents", "logs:CreateLogGroup", "logs:DescribeLogStreams"]
        Effect   = "Allow"
        Resource = "*"
      }]
      Version = "2012-10-17"
    })
  }
}
