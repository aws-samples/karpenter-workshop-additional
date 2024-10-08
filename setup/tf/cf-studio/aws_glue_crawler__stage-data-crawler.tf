##START,aws_glue_crawler
resource "aws_glue_crawler" "stage-data-crawler" {
  classifiers            = []
  configuration          = null
  database_name          = aws_glue_catalog_database.d-011487565228__stage.name
  description            = "Crawler for stage data tables"
  name                   = "stage-data-crawler"
  role                   = aws_iam_role.GlueExecutionRole.id
  schedule               = null
  security_configuration = null
  table_prefix           = "stage_"
  tags                   = {}
  tags_all               = {}
  lake_formation_configuration {
    account_id                     = null
    use_lake_formation_credentials = false
  }
  lineage_configuration {
    crawler_lineage_settings = "DISABLE"
  }
  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }
  s3_target {
    connection_name     = null
    dlq_event_queue_arn = null
    event_queue_arn     = null
    exclusions          = []
    path                = "s3://011487565228-eu-west-1-datalake-stage"
  }
  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }
}
