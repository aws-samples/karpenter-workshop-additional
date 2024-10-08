##START,aws_iam_role
resource "aws_iam_role" "GlueExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = ["glue.amazonaws.com", "lakeformation.amazonaws.com"]
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"]
  max_session_duration  = 3600
  name                  = "GlueExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "CWPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = "cloudwatch:PutMetricData"
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor0"
        }, {
        Action   = "logs:PutLogEvents"
        Effect   = "Allow"
        Resource = format("arn:aws:logs:*:%s:log-group:*:log-stream:*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor1"
        }, {
        Action   = ["logs:CreateLogStream", "logs:CreateLogGroup"]
        Effect   = "Allow"
        Resource = format("arn:aws:logs:*:%s:log-group:*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor2"
        }, {
        Action   = "logs:AssociateKmsKey"
        Effect   = "Allow"
        Resource = format("arn:aws:logs:*:%s:log-group:*", data.aws_caller_identity.current.account_id)
        Sid      = "VisualEditor3"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "GluePolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["lakeformation:GetDataAccess"]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "lakeformationsid"
        }, {
        Action   = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/source/stage_customer_data.py", "arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/source/stage_sales_data.py", "arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/source/dataproduct_sales_data.py", "arn:aws:s3:::ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/source/dataproduct_customers_data.py", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts/*"]
        Sid      = "s3sid"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "LakeFormationTransactionsPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["lakeformation:StartTransaction", "lakeformation:CommitTransaction", "lakeformation:CancelTransaction", "lakeformation:ExtendTransaction", "lakeformation:DescribeTransaction", "lakeformation:ListTransactions", "lakeformation:StartQueryPlanning", "lakeformation:GetQueryState", "lakeformation:GetWorkUnitResults", "lakeformation:GetWorkUnits", "lakeformation:GetQueryStatistics", "lakeformation:GetTableObjects", "lakeformation:UpdateTableObjects", "lakeformation:DeleteObjectsOnCancel"]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor0"
      }]
      Version = "2012-10-17"
    })
  }
  inline_policy {
    name = "PassrolePolicy"
    policy = jsonencode({
      Statement = [{
        Action   = "iam:PassRole"
        Effect   = "Allow"
        Resource = "*"
        Sid      = "VisualEditor0"
      }]
      Version = "2012-10-17"
    })
  }
}
