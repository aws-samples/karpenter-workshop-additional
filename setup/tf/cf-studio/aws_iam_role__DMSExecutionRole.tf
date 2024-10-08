##START,aws_iam_role
resource "aws_iam_role" "DMSExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "dms.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "DMSExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "S3AccessForDMSPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:PutObject", "s3:DeleteObject", "s3:PutObjectTagging"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*"]
        }, {
        Action   = "s3:ListBucket"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::011487565228-eu-west-1-datalake-raw"
      }]
      Version = "2012-10-17"
    })
  }
}
