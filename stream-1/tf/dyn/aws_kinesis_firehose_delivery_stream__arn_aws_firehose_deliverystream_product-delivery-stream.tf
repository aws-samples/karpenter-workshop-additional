##START,aws_kinesis_firehose_delivery_stream
resource "aws_kinesis_firehose_delivery_stream" "arn_aws_firehose_eu-west-1_011487565228_deliverystream_product-delivery-stream" {
  #arn            = format("arn:aws:firehose:%s:%s:deliverystream/product-delivery-stream", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  destination    = "extended_s3"
  name           = "product-delivery-stream"

  lifecycle {
    ignore_changes = [extended_s3_configuration[0].custom_time_zone]
  }
  tags       = {}
  tags_all   = {}
  version_id = jsonencode(1)
  extended_s3_configuration {
    bucket_arn          = data.aws_s3_bucket.raw.arn
    buffering_interval  = 60
    buffering_size      = 128
    compression_format  = "UNCOMPRESSED"
    custom_time_zone    = "UTC"
    error_output_prefix = "error"
    file_extension      = null
    prefix              = "!{partitionKeyFromQuery:tableName}/year=!{partitionKeyFromQuery:year}/month=!{partitionKeyFromQuery:month}/day=!{partitionKeyFromQuery:day}/"
    role_arn            = data.aws_iam_role.FirehoseExecutionRole.arn
    s3_backup_mode      = "Disabled"
    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/product-delivery-stream"
      log_stream_name = "DestinationDelivery"
    }
    dynamic_partitioning_configuration {
      enabled        = true
      retry_duration = 300
    }
    processing_configuration {
      enabled = true
      processors {
        type = "MetadataExtraction"
        parameters {
          parameter_name  = "JsonParsingEngine"
          parameter_value = "JQ-1.6"
        }
        parameters {
          parameter_name  = "MetadataExtractionQuery"
          parameter_value = "{tableName:.tableName,year:(.dynamodb.ApproximateCreationDateTime/1000)| strftime(\"%Y\"),month:(.dynamodb.ApproximateCreationDateTime/1000)| strftime(\"%m\"),day:(.dynamodb.ApproximateCreationDateTime/1000)| strftime(\"%d\")}"
        }
      }
      processors {
        type = "AppendDelimiterToRecord"
      }
    }
  }
  kinesis_source_configuration {
    kinesis_stream_arn = data.aws_kinesis_stream.product-data-stream.arn
    role_arn           = data.aws_iam_role.FirehoseExecutionRole.arn
  }

}
