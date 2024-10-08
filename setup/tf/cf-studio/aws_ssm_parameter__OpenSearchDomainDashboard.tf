##START,aws_ssm_parameter
resource "aws_ssm_parameter" "OpenSearchDomainDashboard" {
  allowed_pattern = null
  data_type       = "text"
  description     = null
  lifecycle {
    ignore_changes = [value]
  }
  key_id   = null
  name     = "OpenSearchDomainDashboard"
  tags     = {}
  tags_all = {}
  tier     = "Standard"
  type     = "String"
  value    = "https://search-aws-mda-aos-cluster-m2jevmssjwukzzjejsjftehyda.eu-west-1.es.amazonaws.com"
}
