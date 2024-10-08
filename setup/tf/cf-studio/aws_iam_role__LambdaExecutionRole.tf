##START,aws_iam_role
resource "aws_iam_role" "LambdaExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
  max_session_duration  = 3600
  name                  = "LambdaExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "ImportPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:*:011487565228:*"]
        Sid      = ""
        }, {
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:*:011487565228:log-group:*:*"]
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "LambdaPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["lambda:InvokeFunction", "lambda:GetFunction"]
        Effect   = "Allow"
        Resource = format("arn:aws:lambda:*:%s:function:*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor0"
        }, {
        Action   = "lambda:ListFunctions"
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor1"
        }, {
        Action   = "cloudformation:*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor2"
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
        Resource = ["arn:aws:secretsmanager:*:011487565228:secret:AuroraSecret-*", "arn:aws:secretsmanager:*:011487565228:secret:RedshiftSecret-*", "arn:aws:secretsmanager:*:011487565228:secret:trianz-snowflake-athena-*"]
        Sid      = ""
      }]
      Version = "2012-10-17"
    })
  }
}
