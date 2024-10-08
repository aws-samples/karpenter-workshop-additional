##START,aws_iam_role
resource "aws_iam_role" "AthenaSparkWorkgroupRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "athena.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "AthenaSparkWorkgroupRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "AthenaWorkgroupPermissions"
    policy = jsonencode({
      Statement = [{
        Action   = ["glue:GetDatabase", "glue:GetTables", "glue:GetPartitions", "glue:CreateDatabase", "glue:GetDatabases", "glue:GetTable"]
        Effect   = "Allow"
        Resource = ["arn:aws:glue:*:011487565228:catalog", "arn:aws:glue:*:011487565228:table/*/*", "arn:aws:glue:*:011487565228:database/*"]
        Sid      = "VisualEditor9"
        }, {
        Action   = ["s3:PutObject", "s3:ListBucket", "s3:DeleteObject", "s3:GetObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-raw", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics/*"]
        Sid      = "1"
        }, {
        Action   = ["s3:PutObject", "s3:ListBucket", "s3:DeleteObject", "s3:GetObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-athenaoutput/*", "arn:aws:s3:::011487565228-eu-west-1-athenaoutput"]
        }, {
        Action   = ["athena:GetWorkGroup", "athena:TerminateSession", "athena:GetSession", "athena:GetSessionStatus", "athena:ListSessions", "athena:StartCalculationExecution", "athena:GetCalculationExecutionCode", "athena:StopCalculationExecution", "athena:ListCalculationExecutions", "athena:GetCalculationExecution", "athena:GetCalculationExecutionStatus", "athena:ListExecutors", "athena:ExportNotebook", "athena:UpdateNotebook"]
        Effect   = "Allow"
        Resource = format("arn:aws:athena:%s:%s:workgroup/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        }, {
        Action   = ["logs:CreateLogStream", "logs:DescribeLogStreams", "logs:CreateLogGroup", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:eu-west-1:011487565228:log-group:/aws-athena:*", "arn:aws:logs:eu-west-1:011487565228:log-group:/aws-athena*:log-stream:*"]
        Sid      = "VisualEditor0"
        }, {
        Action   = "logs:DescribeLogGroups"
        Effect   = "Allow"
        Resource = format("arn:aws:logs:%s:%s:log-group:*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor1"
        }, {
        Action = ["cloudwatch:PutMetricData"]
        Condition = {
          StringEquals = {
            "cloudwatch:namespace" = "AmazonAthenaForApacheSpark"
          }
        }
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor2"
      }]
      Version = "2012-10-17"
    })
  }
}
