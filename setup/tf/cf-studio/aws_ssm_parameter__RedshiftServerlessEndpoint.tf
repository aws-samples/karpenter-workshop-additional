##START,aws_ssm_parameter
resource "aws_ssm_parameter" "RedshiftServerlessEndpoint" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "RedshiftServerlessEndpoint"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "mdawarehouse-workgroup.011487565228.eu-west-1.redshift-serverless.amazonaws.com:5439"
}
