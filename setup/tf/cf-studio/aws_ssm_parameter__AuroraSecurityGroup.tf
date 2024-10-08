##START,aws_ssm_parameter
resource "aws_ssm_parameter" "AuroraSecurityGroup" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "AuroraSecurityGroup"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "sg-073e9a2702bb17464"
}
