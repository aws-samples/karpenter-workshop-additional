##START,aws_s3_bucket_request_payment_configuration
resource "aws_s3_bucket_request_payment_configuration" "b-011487565228-eu-west-1-athenaoutput" {
  bucket                = aws_s3_bucket.b-011487565228-eu-west-1-athenaoutput.bucket
  expected_bucket_owner = null
  payer                 = "BucketOwner"
}
