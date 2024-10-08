##START,aws_s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  bucket                = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  expected_bucket_owner = null
  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
