##START,aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  bucket = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
