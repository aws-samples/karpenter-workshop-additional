##START,aws_iam_role
resource "aws_iam_role" "DatalakeInit-eu-west-1-DataLakeInitExecutionRole" {
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
  max_session_duration  = 3600
  name                  = "DatalakeInit-eu-west-1-DataLakeInitExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "DatalakeInit-eu-west-1-AWSLambda-CW"
    policy = jsonencode({
      Statement = [{
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "DatalakeInit-eu-west-1-AWSLambda-S3"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406*/*", "arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406*"]
        }, {
        Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw"]
      }]
      Version = "2012-10-17"
    })
  }
}
