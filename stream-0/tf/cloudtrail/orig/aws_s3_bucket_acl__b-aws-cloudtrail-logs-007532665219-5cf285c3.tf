##START,aws_s3_bucket_acl
resource "aws_s3_bucket_acl" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  acl                   = null
  bucket                = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  expected_bucket_owner = null
  access_control_policy {
    grant {
      permission = "FULL_CONTROL"
      grantee {
        email_address = null
        id            = "e068ae4428dc150258ab2ecf489a95e2ad76a1a86b87ac74055a2cee23a9900a"
        type          = "CanonicalUser"
        uri           = null
      }
    }
    owner {
      display_name = "ee-account+229f01e5ac98494e8f19477222cec8a6"
      id           = "e068ae4428dc150258ab2ecf489a95e2ad76a1a86b87ac74055a2cee23a9900a"
    }
  }
}
