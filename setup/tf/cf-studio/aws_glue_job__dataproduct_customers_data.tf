##START,aws_glue_job
resource "aws_glue_job" "dataproduct_customers_data" {
  connections = []
  default_arguments = {
    "--enable-continuous-cloudwatch-log" = "true"
    "--output_s3_bucket_name"            = aws_s3_bucket.b-011487565228-eu-west-1-datalake-dataproducts.bucket
  }
  description = null

  lifecycle {
    ignore_changes = [glue_version, number_of_workers, worker_type]
  }
  execution_class           = null
  glue_version              = jsonencode(4)
  maintenance_window        = null
  max_capacity              = 20
  max_retries               = 0
  name                      = "dataproduct_customers_data"
  non_overridable_arguments = {}
  role_arn                  = format("arn:aws:iam::%s:role/GlueExecutionRole", data.aws_caller_identity.current.account_id)
  security_configuration    = null
  tags                      = {}
  tags_all                  = {}
  timeout                   = 15
  command {
    name            = "glueetl"
    python_version  = jsonencode(3)
    runtime         = null
    script_location = "s3://ws-assets-prod-iad-r-dub-85e3be25bd827406/32f3e732-d67d-4c63-b967-c8c5eabd9ebf/v6_2/source/dataproduct_customers_data.py"
  }
  execution_property {
    max_concurrent_runs = 1
  }
}
