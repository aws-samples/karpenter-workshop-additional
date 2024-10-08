##START,aws_s3_bucket_acl
resource "aws_s3_bucket_acl" "b-011487565228-eu-west-1-datalake-raw" {
  acl                   = null
  bucket                = aws_s3_bucket.b-011487565228-eu-west-1-datalake-raw.bucket
  expected_bucket_owner = null
  access_control_policy {
    grant {
      permission = "FULL_CONTROL"
      grantee {
        email_address = null
        id            = "110b4f4fdd941b3609aa613844d6f66704c47a6625323c086e514d73ba6ab0f8"
        type          = "CanonicalUser"
        uri           = null
      }
    }
    owner {
      display_name = "ee-account+04331b1b7da744aebdb40a3d56c2ba01"
      id           = "110b4f4fdd941b3609aa613844d6f66704c47a6625323c086e514d73ba6ab0f8"
    }
  }
}
