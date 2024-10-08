##START,aws_ssm_parameter
resource "aws_ssm_parameter" "RedshiftServerlessWorkgroup" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "RedshiftServerlessWorkgroup"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "mdawarehouse-workgroup"
}
