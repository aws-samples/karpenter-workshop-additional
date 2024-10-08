##START,aws_ssm_parameter
resource "aws_ssm_parameter" "LambdaExecutionRoleArn" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "LambdaExecutionRoleArn"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "arn:aws:iam::011487565228:role/LambdaExecutionRole"
}
