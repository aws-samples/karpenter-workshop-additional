##START,aws_iam_role
resource "aws_iam_role" "DatabrewExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "databrew.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AWSGlueDataBrewServiceRole"]
  max_session_duration  = 3600
  name                  = "DatabrewExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "S3Policy"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-databrew/*", "arn:aws:s3:::011487565228-eu-west-1-databrew"]
        }, {
        Action   = ["s3:PutObjectAcl"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-databrew/*"]
        }, {
        Action   = ["s3:ListBucket", "s3:GetObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-stage/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage"]
        }, {
        Action = ["kms:Decrypt"]
        Condition = {
          StringLike = {
            "kms:ViaService" = ["s3.*.amazonaws.com"]
          }
        }
        Effect   = "Allow"
        Resource = ["arn:aws:kms:eu-west-1:011487565228:key/*"]
      }]
      Version = "2012-10-17"
    })
  }
}
