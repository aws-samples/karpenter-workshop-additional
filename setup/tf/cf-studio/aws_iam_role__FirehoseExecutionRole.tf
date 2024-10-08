##START,aws_iam_role
resource "aws_iam_role" "FirehoseExecutionRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "firehose.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess"]
  max_session_duration  = 3600
  name                  = "FirehoseExecutionRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "CustomKinesisFirehosePolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["glue:GetTable", "glue:GetTableVersion", "glue:GetTableVersions"]
        Effect   = "Allow"
        Resource = ["arn:aws:glue:eu-west-1:011487565228:catalog", "arn:aws:glue:eu-west-1:011487565228:database/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%", "arn:aws:glue:eu-west-1:011487565228:table/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"]
        Sid      = ""
        }, {
        Action   = ["s3:AbortMultipartUpload", "s3:GetBucketLocation", "s3:GetObject", "s3:ListBucket", "s3:ListBucketMultipartUploads", "s3:PutObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::011487565228-eu-west-1-datalake-raw", "arn:aws:s3:::011487565228-eu-west-1-datalake-raw/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage", "arn:aws:s3:::011487565228-eu-west-1-datalake-stage/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics", "arn:aws:s3:::011487565228-eu-west-1-datalake-analytics/*", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts", "arn:aws:s3:::011487565228-eu-west-1-datalake-dataproducts/*"]
        Sid      = ""
        }, {
        Action   = ["lambda:InvokeFunction", "lambda:GetFunctionConfiguration"]
        Effect   = "Allow"
        Resource = format("arn:aws:lambda:%s:%s:function:%%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%%", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        Sid      = ""
        }, {
        Action = ["kms:GenerateDataKey", "kms:Decrypt"]
        Condition = {
          StringEquals = {
            "kms:ViaService" = "s3.eu-west-1.amazonaws.com"
          }
          StringLike = {
            "kms:EncryptionContext:aws:s3:arn" = ["arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%/*", "arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"]
          }
        }
        Effect   = "Allow"
        Resource = ["arn:aws:kms:eu-west-1:011487565228:key/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"]
        }, {
        Action   = ["logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:eu-west-1:011487565228:log-group:/aws/kinesisfirehose/*", "arn:aws:logs:eu-west-1:011487565228:log-group:%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%:log-stream:*"]
        Sid      = ""
        }, {
        Action   = ["kinesis:DescribeStream", "kinesis:GetShardIterator", "kinesis:GetRecords", "kinesis:ListShards"]
        Effect   = "Allow"
        Resource = format("arn:aws:kinesis:%s:%s:stream/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        Sid      = ""
      }]
      Version = "2012-10-17"
    })
  }
}
