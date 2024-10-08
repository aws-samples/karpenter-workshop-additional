##START,aws_s3_bucket
resource "aws_s3_bucket" "b-aws-cloudtrail-logs-011487565228-5f1bc7e1" {
  bucket              = format("aws-cloudtrail-logs-%s-%s",data.aws_caller_identity.current.account_id,random_id.rand.hex)
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
