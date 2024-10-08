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
  managed_policy_arns   = [format("arn:aws:iam::%s:policy/service-role/Cloudtrail-CW-access-policy-mda-events-973a88c1-7d66-4de6-8b9a-1f5c588f91f8", data.aws_caller_identity.current.account_id)]
  max_session_duration  = 3600
  name                  = "mda-cw-role"
  path                  = "/service-role/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
