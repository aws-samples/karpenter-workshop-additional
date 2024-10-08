##START,aws_s3_bucket_request_payment_configuration
resource "aws_s3_bucket_request_payment_configuration" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  bucket                = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  expected_bucket_owner = null
  payer                 = "BucketOwner"
}
