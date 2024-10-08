##START,aws_ssm_parameter
resource "aws_ssm_parameter" "AthenaSpillBucketName" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "AthenaSpillBucketName"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "011487565228-eu-west-1-athenaspill"
}
