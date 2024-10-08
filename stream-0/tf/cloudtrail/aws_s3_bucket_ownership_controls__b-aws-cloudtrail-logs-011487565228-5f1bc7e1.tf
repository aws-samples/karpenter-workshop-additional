##START,aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "b-aws-cloudtrail-logs-011487565228-5f1bc7e1" {
  bucket = aws_s3_bucket.b-aws-cloudtrail-logs-011487565228-5f1bc7e1.bucket
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
