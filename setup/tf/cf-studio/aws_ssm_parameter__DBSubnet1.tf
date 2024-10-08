##START,aws_ssm_parameter
resource "aws_ssm_parameter" "DBSubnet1" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "DBSubnet1"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "subnet-0a18186bf0066af18"
}
