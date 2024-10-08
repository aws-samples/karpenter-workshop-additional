##START,aws_ssm_parameter
resource "aws_ssm_parameter" "LambdaSecurityGroup" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "LambdaSecurityGroup"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "sg-0fbb1938b230b23dc"
}
