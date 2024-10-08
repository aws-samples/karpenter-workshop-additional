##START,aws_athena_workgroup
resource "aws_athena_workgroup" "AmazonAthenaLakeFormation" {
  description   = "A workgroup for Lake Formation"
  force_destroy = false
  name          = "AmazonAthenaLakeFormation"
  state         = "ENABLED"
  tags          = {}
  tags_all      = {}
  configuration {
    bytes_scanned_cutoff_per_query     = 0
    enforce_workgroup_configuration    = true
    execution_role                     = null
    publish_cloudwatch_metrics_enabled = true
    requester_pays_enabled             = false
    engine_version {
      selected_engine_version = "AUTO"
    }
    result_configuration {
      expected_bucket_owner = null
      output_location       = "s3://011487565228-eu-west-1-athenaoutput"
    }
  }
}
