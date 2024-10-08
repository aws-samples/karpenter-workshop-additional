data "aws_s3_bucket" "raw" {
    bucket = format("%s-%s-datalake-raw",data.aws_caller_identity.current.account_id,data.aws_region.current.name)
}