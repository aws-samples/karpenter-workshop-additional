##START,aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "b-011487565228-eu-west-1-datalake-dataproducts" {
  bucket = aws_s3_bucket.b-011487565228-eu-west-1-datalake-dataproducts.bucket
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
