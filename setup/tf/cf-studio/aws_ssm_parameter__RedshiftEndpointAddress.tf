##START,aws_ssm_parameter
resource "aws_ssm_parameter" "RedshiftEndpointAddress" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "RedshiftEndpointAddress"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "mdawarehouse-tsdvavsju6ac.cpesacqvqywx.eu-west-1.redshift.amazonaws.com"
}
