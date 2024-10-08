##START,aws_kinesis_stream
resource "aws_kinesis_stream" "product-data-stream" {
  encryption_type           = "NONE"
  enforce_consumer_deletion = null
  name                      = "product-data-stream"
  retention_period          = 24
  shard_count               = 1
  shard_level_metrics       = []
  tags                      = {}
  tags_all                  = {}
  stream_mode_details {
    stream_mode = "PROVISIONED"
  }
}
