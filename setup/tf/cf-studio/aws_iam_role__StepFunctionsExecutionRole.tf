##START,aws_iam_role
resource "aws_iam_role" "StepFunctionsExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "states.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "StepFunctionsExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "CloudWatch"
    policy = jsonencode({
      Statement = [{
        Action   = ["logs:CreateLogDelivery", "logs:GetLogDelivery", "logs:UpdateLogDelivery", "logs:DeleteLogDelivery", "logs:ListLogDeliveries", "logs:PutResourcePolicy", "logs:DescribeResourcePolicies", "logs:DescribeLogGroups"]
        Effect   = "Allow"
        Resource = "*"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "Glue"
    policy = jsonencode({
      Statement = [{
        Action   = ["glue:StartCrawler", "glue:GetCrawler"]
        Effect   = "Allow"
        Resource = format("arn:aws:glue:*:%s:crawler/*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor0"
        }, {
        Action   = ["glue:StartJobRun", "glue:GetJobRun", "glue:GetJobRuns"]
        Effect   = "Allow"
        Resource = format("arn:aws:glue:*:%s:job/*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor1"
        }, {
        Action   = ["glue:SearchTables", "glue:UpdateDatabase", "glue:CreateTable", "glue:DeleteDatabase", "glue:GetTables", "glue:GetTableVersions", "glue:UpdateTable", "glue:DeleteTable", "glue:GetDatabases", "glue:GetTable", "glue:GetDatabase", "glue:GetTableVersion", "glue:CreateDatabase"]
        Effect   = "Allow"
        Resource = ["arn:aws:glue:*:011487565228:database/*", "arn:aws:glue:*:011487565228:catalog", "arn:aws:glue:*:011487565228:table/*/*"]
        Sid      = "VisualEditor2"
        }, {
        Action   = ["glue:SearchTables", "glue:UpdateDatabase", "glue:CreateTable", "glue:DeleteDatabase", "glue:GetTables", "glue:GetTableVersions", "glue:UpdateTable", "glue:DeleteTable", "glue:GetDatabases", "glue:GetTable", "glue:GetDatabase", "glue:GetTableVersion", "glue:CreateDatabase"]
        Effect   = "Allow"
        Resource = ["arn:aws:glue:*:011487565228:database/*", "arn:aws:glue:*:011487565228:table/*"]
        Sid      = "VisualEditor3"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "LakeFormation"
    policy = jsonencode({
      Statement = [{
        Action   = ["lakeformation:GetEffectivePermissionsForPath", "lakeformation:BatchGrantPermissions", "lakeformation:SearchDatabasesByLFTags", "glue:GetJobs", "lakeformation:SearchTablesByLFTags", "lakeformation:GetWorkUnits", "lakeformation:ListLFTags", "lakeformation:GetWorkUnitResults", "lakeformation:GetLFTag", "lakeformation:GetQueryState", "lakeformation:BatchRevokePermissions", "lakeformation:GetResourceLFTags", "lakeformation:DescribeResource", "lakeformation:GrantPermissions", "lakeformation:GetQueryStatistics", "lakeformation:GetDataLakeSettings", "lakeformation:GetTableObjects", "lakeformation:PutDataLakeSettings", "lakeformation:RevokePermissions", "lakeformation:DescribeTransaction"]
        Effect   = "Allow"
        Resource = ["*"]
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "XRay"
    policy = jsonencode({
      Statement = [{
        Action   = ["xray:PutTraceSegments", "xray:PutTelemetryRecords", "xray:GetSamplingRules", "xray:GetSamplingTargets"]
        Effect   = "Allow"
        Resource = ["*"]
      }]
      Version = "2012-10-17"
    })
  }
}
