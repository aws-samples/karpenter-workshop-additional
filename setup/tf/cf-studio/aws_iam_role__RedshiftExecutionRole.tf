##START,aws_iam_role
resource "aws_iam_role" "RedshiftExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "redshift.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess", "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  max_session_duration  = 3600
  name                  = "RedshiftExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "CustomS3Policy"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:PutObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-raw", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts/*"]
        Sid      = "VisualEditor0"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "SecretsPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["secretsmanager:GetResourcePolicy", "secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret", "secretsmanager:ListSecretVersionIds"]
        Effect   = "Allow"
        Resource = format("arn:aws:secretsmanager:*:%s:secret:AuroraSecret-*", data.aws_caller_identity.current.account_id)
        Sid      = "AccessSecret"
        }, {
        Action   = ["secretsmanager:GetRandomPassword", "secretsmanager:ListSecrets"]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor1"
      }]
      Version = "2012-10-17"
    })
  }
}
