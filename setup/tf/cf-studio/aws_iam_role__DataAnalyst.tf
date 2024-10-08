##START,aws_iam_role
resource "aws_iam_role" "DataAnalyst" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = format("arn:aws:iam::%s:role/WSParticipantRole", data.aws_caller_identity.current.account_id)
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonAthenaFullAccess", "arn:aws:iam::aws:policy/AmazonDataZoneFullUserAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  max_session_duration  = 3600
  name                  = "DataAnalyst"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "LakeFormation"
    policy = jsonencode({
      Statement = [{
        Action   = ["lakeformation:StartQueryPlanning", "lakeformation:GetQueryState", "lakeformation:GetWorkUnits", "lakeformation:GetWorkUnitResults"]
        Effect   = "Allow"
        Resource = "*"
        }, {
        Action   = ["athena:ListEngineVersions", "athena:ListWorkGroups", "athena:ListDataCatalogs", "athena:ListDatabases", "athena:GetDatabase", "athena:ListTableMetadata", "athena:GetTableMetadata"]
        Effect   = "Allow"
        Resource = "*"
        }, {
        Action   = ["athena:BatchGetQueryExecution", "athena:GetQueryExecution", "athena:ListQueryExecutions", "athena:StartQueryExecution", "athena:StopQueryExecution", "athena:GetQueryResults", "athena:GetQueryResultsStream", "athena:CreateNamedQuery", "athena:GetNamedQuery", "athena:BatchGetNamedQuery", "athena:ListNamedQueries", "athena:DeleteNamedQuery", "athena:CreatePreparedStatement", "athena:GetPreparedStatement", "athena:ListPreparedStatements", "athena:UpdatePreparedStatement", "athena:DeletePreparedStatement"]
        Effect   = "Allow"
        Resource = ["arn:aws:athena:eu-west-1:011487565228:workgroup/*"]
      }]
      Version = "2012-10-17"
    })
  }
}
