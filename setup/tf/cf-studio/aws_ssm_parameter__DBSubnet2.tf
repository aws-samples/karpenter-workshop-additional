##START,aws_ssm_parameter
resource "aws_ssm_parameter" "DBSubnet2" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "DBSubnet2"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "subnet-02fb3e24f83650b37"
}
