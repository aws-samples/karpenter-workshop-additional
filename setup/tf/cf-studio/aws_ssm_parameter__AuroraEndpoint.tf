##START,aws_ssm_parameter
resource "aws_ssm_parameter" "AuroraEndpoint" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "AuroraEndpoint"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "mdadb.cdky46ck0ecj.eu-west-1.rds.amazonaws.com"
}
