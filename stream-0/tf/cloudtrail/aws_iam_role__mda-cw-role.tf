##START,aws_iam_role
resource "aws_iam_role" "mda-cw-role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = "Role for config CloudWathLogs for trail mda-events"
  force_detach_policies = false
  managed_policy_arns   = [aws_iam_policy.Cloudtrail-CW-access-policy-mda-events-4b64828a-9f27-43d9-a3e3-d0e8028141c5.arn]
  max_session_duration  = 3600
  name                  = "mda-cw-role"
  path                  = "/service-role/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
