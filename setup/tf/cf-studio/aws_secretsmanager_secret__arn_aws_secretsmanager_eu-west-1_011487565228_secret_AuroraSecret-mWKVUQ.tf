##START,aws_secretsmanager_secret
resource "aws_secretsmanager_secret" "arn_aws_secretsmanager_eu-west-1_011487565228_secret_AuroraSecret-mWKVUQ" {
  description                    = "Aurora secret"
  force_overwrite_replica_secret = false
  name                           = "AuroraSecret"
  name_prefix                    = null
  policy                         = null
  recovery_window_in_days        = 30
  lifecycle {
    ignore_changes = [recovery_window_in_days, force_overwrite_replica_secret]
  }
  tags     = {}
  tags_all = {}
}
