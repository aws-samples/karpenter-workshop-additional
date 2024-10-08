##START,aws_lambda_function
resource "aws_lambda_function" "detectTextSentiment" {
  architectures           = ["x86_64"]
  code_signing_config_arn = null
  description             = "Function to call SageMaker Endpoint"
  filename                = "aws_lambda_function__detectTextSentiment.zip"
  lifecycle {
    ignore_changes = [filename, publish, source_code_hash]
  }
  function_name                      = "detectTextSentiment"
  handler                            = "com.amazonaws.athena.udf.textsentiment.SentimentAnalysisUDFHandler"
  layers                             = []
  memory_size                        = 512
  package_type                       = "Zip"
  publish                            = null
  replace_security_groups_on_destroy = null
  replacement_security_group_ids     = null
  reserved_concurrent_executions     = -1
  role                               = aws_iam_role.LambdaIAMrole.arn
  runtime                            = "java8.al2"
  s3_key                             = null
  s3_object_version                  = null
  skip_destroy                       = false
  source_code_hash                   = filebase64sha256("aws_lambda_function__detectTextSentiment.zip")
  tags                               = {}
  tags_all                           = {}
  timeout                            = 900
  environment {
    variables = {
      SM_ENDPOINT = "bt-nlp-endpoint"
    }
  }
  ephemeral_storage {
    size = 512
  }
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/detectTextSentiment"
    system_log_level      = null
  }
  tracing_config {
    mode = "PassThrough"
  }
}
