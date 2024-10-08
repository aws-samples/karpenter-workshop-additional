##START,aws_ssm_parameter
resource "aws_ssm_parameter" "Database" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "Database"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "vpc-0e4eecd9b51408770"
}
