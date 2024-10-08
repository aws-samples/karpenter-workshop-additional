##START,aws_lambda_function
resource "aws_lambda_function" "DatalakeInit-eu-west-1-lambda" {
  architectures           = ["x86_64"]
  code_signing_config_arn = null
  description             = "Work with S3 Bucket 011487565228-eu-west-1-datalake-raw"
  filename                = "aws_lambda_function__DatalakeInit-eu-west-1-lambda.zip"
  lifecycle {
    ignore_changes = [filename, publish, source_code_hash]
  }
  function_name                      = "DatalakeInit-eu-west-1-lambda"
  handler                            = "index.handler"
  layers                             = []
  memory_size                        = 128
  package_type                       = "Zip"
  publish                            = null
  replace_security_groups_on_destroy = null
  replacement_security_group_ids     = null
  reserved_concurrent_executions     = -1
  role                               = aws_iam_role.DatalakeInit-eu-west-1-DataLakeInitExecutionRole.arn
  runtime                            = "python3.12"
  s3_key                             = null
  s3_object_version                  = null
  skip_destroy                       = false
  source_code_hash                   = filebase64sha256("aws_lambda_function__DatalakeInit-eu-west-1-lambda.zip")
  tags                               = {}
  tags_all                           = {}
  timeout                            = 360
  ephemeral_storage {
    size = 512
  }
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/DatalakeInit-eu-west-1-lambda"
    system_log_level      = null
  }
  tracing_config {
    mode = "PassThrough"
  }
}
