##START,aws_ssm_parameter
resource "aws_ssm_parameter" "AuroraSecretARN" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "AuroraSecretARN"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "arn:aws:secretsmanager:eu-west-1:011487565228:secret:AuroraSecret-mWKVUQ"
}
