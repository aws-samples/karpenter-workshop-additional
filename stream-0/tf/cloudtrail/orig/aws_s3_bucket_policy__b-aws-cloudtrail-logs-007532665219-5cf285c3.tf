##START,aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "b-aws-cloudtrail-logs-007532665219-5cf285c3" {
  bucket = aws_s3_bucket.b-aws-cloudtrail-logs-007532665219-5cf285c3.bucket
  policy = jsonencode({
    Statement = [{
      Action = "s3:GetBucketAcl"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = format("arn:aws:cloudtrail:%s:%s:trail/mda-events", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        }
      }
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Resource = "arn:aws:s3:::aws-cloudtrail-logs-007532665219-5cf285c3"
      Sid      = "AWSCloudTrailAclCheck20150319-f1b2e512-2dfa-4d8c-814a-b129233125ac"
      }, {
      Action = "s3:PutObject"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = format("arn:aws:cloudtrail:%s:%s:trail/mda-events", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
          "s3:x-amz-acl"  = "bucket-owner-full-control"
        }
      }
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Resource = "arn:aws:s3:::aws-cloudtrail-logs-007532665219-5cf285c3/AWSLogs/007532665219/*"
      Sid      = "AWSCloudTrailWrite20150319-916e75d7-9b78-4e9e-aea5-1a686dccbff4"
    }]
    Version = "2012-10-17"
  })
}
