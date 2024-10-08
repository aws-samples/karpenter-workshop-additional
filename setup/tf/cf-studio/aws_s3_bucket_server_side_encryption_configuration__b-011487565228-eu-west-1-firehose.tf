##START,aws_s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "b-011487565228-eu-west-1-firehose" {
  bucket                = aws_s3_bucket.b-011487565228-eu-west-1-firehose.bucket
  expected_bucket_owner = null
  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
