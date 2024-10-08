##START,aws_s3_bucket_request_payment_configuration
resource "aws_s3_bucket_request_payment_configuration" "b-aws-cloudtrail-logs-011487565228-5f1bc7e1" {
  bucket                = aws_s3_bucket.b-aws-cloudtrail-logs-011487565228-5f1bc7e1.bucket
  expected_bucket_owner = null
  payer                 = "BucketOwner"
}
