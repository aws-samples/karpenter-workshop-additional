##START,aws_iam_policy
resource "aws_iam_policy" "Cloudtrail-CW-access-policy-mda-events-4b64828a-9f27-43d9-a3e3-d0e8028141c5" {
  description = "Policy for config CloudWathLogs for trail mda-events, created by CloudTrail console"
  name        = "Cloudtrail-CW-access-policy-mda-events-4b64828a-9f27-43d9-a3e3-d0e8028141c5"
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = ["logs:CreateLogStream"]
      Effect   = "Allow"
      Resource = [format("%s:log-stream:%s_CloudTrail_%s*",aws_cloudwatch_log_group.aws-cloudtrail-logs-007532665219-a908e677.arn,data.aws_caller_identity.current.account_id,data.aws_region.current.name)]
      Sid      = "AWSCloudTrailCreateLogStream2014110"
      }, {
      Action   = ["logs:PutLogEvents"]
      Effect   = "Allow"
#      Resource = [format("arn:aws:logs:%s:%s:log-group:aws-cloudtrail-logs-%s-%s:log-stream:%s_CloudTrail_%s*",data.aws_region.current.name, data.aws_caller_identity.current.account_id,data.aws_caller_identity.current.account_id,random_id.rand.hex,data.aws_caller_identity.current.account_id,data.aws_region.current.name)]
      Resource = [format("%s:log-stream:%s_CloudTrail_%s*",aws_cloudwatch_log_group.aws-cloudtrail-logs-007532665219-a908e677.arn,data.aws_caller_identity.current.account_id,data.aws_region.current.name)]
      Sid      = "AWSCloudTrailPutLogEvents20141101"
    }]
    Version = "2012-10-17"
  })
  tags     = {}
  tags_all = {}
}
