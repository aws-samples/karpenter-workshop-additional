##START,aws_glue_catalog_database
resource "aws_glue_catalog_database" "d-007532665219__default" {
  catalog_id   = format("%s", data.aws_caller_identity.current.account_id)
  description  = null
  location_uri = null
  name         = "default"
  parameters   = {}
  tags         = {}
  tags_all     = {}
}
