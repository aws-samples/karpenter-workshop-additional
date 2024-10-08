##START,aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "b-aws-cloudtrail-logs-011487565228-5f1bc7e1" {
  bucket = aws_s3_bucket.b-aws-cloudtrail-logs-011487565228-5f1bc7e1.bucket
  policy = jsonencode(    Statement = [
      #{
      #Action = "s3:GetBucketAcl"
      #Condition = {
      #  StringEquals = {
      #    "AWS:SourceArn" = format("arn:aws:cloudtrail:%s:%s:trail/mda-events", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
      #  }
      #}
      #Effect = "Allow"
      #Principal = {
      #  Service = "cloudtrail.amazonaws.com"
      #}
      #Resource = aws_cloudwatch_log_group.aws-cloudtrail-logs-007532665219-a908e677.arn
      #Sid      = "AWSCloudTrailAclCheck20150319-9adffa41-6289-4cd0-b829-c69f1d2afeb8"
      #}, 
      {
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
      Resource = format("%s*",aws_cloudwatch_log_group.aws-cloudtrail-logs-007532665219-a908e677.arn)
      Sid      = "AWSCloudTrailWrite20150319-d4a15b81-9f58-41ae-bfa9-1ca57577ea1a"
      }
    ]
    Version = "2012-10-17"
  })
}
