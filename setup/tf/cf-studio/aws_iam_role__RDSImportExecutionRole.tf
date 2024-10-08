##START,aws_iam_role
resource "aws_iam_role" "RDSImportExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "rds.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "RDSImportExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "ImportPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/data/*"]
        Sid      = ""
      }]
      Version = "2012-10-17"
    })
  }
}
