##START,aws_s3_bucket
resource "aws_s3_bucket" "b-011487565228-eu-west-1-databrew" {
  bucket              = "011487565228-eu-west-1-databrew"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
