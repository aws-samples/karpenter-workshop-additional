##START,aws_glue_catalog_database
resource "aws_glue_catalog_database" "d-011487565228__stage" {
  catalog_id   = format("%s", data.aws_caller_identity.current.account_id)
  description  = "Tier 2/Stage Database"
  location_uri = "s3://011487565228-eu-west-1-datalake-stage"
  name         = "stage"
  parameters   = {}
  tags         = {}
  tags_all     = {}
}
