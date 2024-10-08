##START,aws_dynamodb_table
resource "aws_dynamodb_table" "Product" {
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  hash_key                    = "Product_Id"
  name                        = "Product"
  range_key                   = null
  read_capacity               = 1
  restore_date_time           = null
  restore_source_name         = null
  restore_source_table_arn    = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all                    = {}
  write_capacity              = 1
  attribute {
    name = "Product_Id"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = null
    enabled        = false
  }
}

resource "aws_dynamodb_kinesis_streaming_destination" "Product_arn_aws_kinesis_eu-west-1_007532665219_stream_product-data-stream" {
  stream_arn = data.aws_kinesis_stream.product-data-stream.arn
  table_name = aws_dynamodb_table.Product.name
}
