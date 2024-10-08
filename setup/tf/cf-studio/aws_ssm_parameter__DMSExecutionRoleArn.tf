##START,aws_ssm_parameter
resource "aws_ssm_parameter" "DMSExecutionRoleArn" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "DMSExecutionRoleArn"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "arn:aws:iam::011487565228:role/DMSExecutionRole"
}
