##START,aws_s3_bucket
resource "aws_s3_bucket" "b-011487565228-eu-west-1-athenaspill" {
  bucket              = "011487565228-eu-west-1-athenaspill"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
