##START,aws_s3_bucket
resource "aws_s3_bucket" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  bucket              = "aws-cloudtrail-logs-007532665219-5cf285c3"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
