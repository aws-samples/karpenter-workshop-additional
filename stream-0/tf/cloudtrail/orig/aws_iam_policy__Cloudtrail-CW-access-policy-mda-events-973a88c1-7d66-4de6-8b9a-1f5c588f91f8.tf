##START,aws_iam_policy
resource "aws_iam_policy" "Cloudtrail-CW-access-policy-mda-events-973a88c1-7d66-4de6-8b9a-1f5c588f91f8" {
  description = "Policy for config CloudWathLogs for trail mda-events, created by CloudTrail console"
  name        = "Cloudtrail-CW-access-policy-mda-events-973a88c1-7d66-4de6-8b9a-1f5c588f91f8"
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = ["logs:CreateLogStream"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-west-1:007532665219:log-group:aws-cloudtrail-logs-007532665219-bdd32b3f:log-stream:007532665219_CloudTrail_eu-west-1*"]
      Sid      = "AWSCloudTrailCreateLogStream2014110"
      }, {
      Action   = ["logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-west-1:007532665219:log-group:aws-cloudtrail-logs-007532665219-bdd32b3f:log-stream:007532665219_CloudTrail_eu-west-1*"]
      Sid      = "AWSCloudTrailPutLogEvents20141101"
    }]
    Version = "2012-10-17"
  })
  tags     = {}
  tags_all = {}
}
