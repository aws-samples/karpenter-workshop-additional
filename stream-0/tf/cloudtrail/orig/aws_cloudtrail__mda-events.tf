##START,aws_cloudtrail
resource "aws_cloudtrail" "mda-events" {
  cloud_watch_logs_group_arn    = format("arn:aws:logs:%s:%s:log-group:aws-cloudtrail-logs-007532665219-bdd32b3f:*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  cloud_watch_logs_role_arn     = aws_iam_role.mda-cw-role.arn
  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = false
  kms_key_id                    = aws_kms_key.k-52084661-d2d7-43ae-a54f-ebefc1c4c61a.arn
  name                          = "mda-events"
  s3_bucket_name                = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  s3_key_prefix                 = null
  sns_topic_name                = null
  tags                          = {}
  tags_all                      = {}
  advanced_event_selector {
    name = null
    field_selector {
      equals = ["AWS::Glue::Table"]
      field  = "resources.type"
    }
    field_selector {
      equals = ["Data"]
      field  = "eventCategory"
    }
  }
  advanced_event_selector {
    name = "Management events selector"
    field_selector {
      equals = ["Management"]
      field  = "eventCategory"
    }
    field_selector {
      field      = "eventSource"
      not_equals = ["kms.amazonaws.com", "rdsdata.amazonaws.com"]
    }
  }
}
