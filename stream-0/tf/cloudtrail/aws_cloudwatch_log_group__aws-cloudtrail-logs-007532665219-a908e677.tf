##START,aws_cloudwatch_log_group
resource "aws_cloudwatch_log_group" "aws-cloudtrail-logs-007532665219-a908e677" {
  log_group_class   = "STANDARD"
  name              = format("aws-cloudtrail-logs-%s-%s",data.aws_caller_identity.current.account_id,random_id.rand.hex)
  retention_in_days = 0
  skip_destroy      = false
  tags              = {}
  tags_all          = {}
}
