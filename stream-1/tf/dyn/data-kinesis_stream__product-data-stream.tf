##START,aws_kinesis_stream
data "aws_kinesis_stream" "product-data-stream" {
    name  = "product-data-stream"
}
