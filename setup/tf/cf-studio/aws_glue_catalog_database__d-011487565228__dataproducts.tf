##START,aws_glue_catalog_database
resource "aws_glue_catalog_database" "d-011487565228__dataproducts" {
  catalog_id   = format("%s", data.aws_caller_identity.current.account_id)
  description  = "Data Products Database"
  location_uri = "s3://011487565228-eu-west-1-datalake-dataproducts"
  name         = "dataproducts"
  parameters   = {}
  tags         = {}
  tags_all     = {}
}
