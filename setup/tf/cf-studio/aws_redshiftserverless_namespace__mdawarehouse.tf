##START,aws_redshiftserverless_namespace
resource "aws_redshiftserverless_namespace" "mdawarehouse" {
  admin_password_secret_kms_key_id = null
  admin_user_password              = null # sensitive
  admin_username                   = null # sensitive
  db_name                          = "dev"
  default_iam_role_arn             = null
  iam_roles                        = [aws_iam_role.RedshiftExecutionRole.arn]
  log_exports                      = ["connectionlog", "useractivitylog", "userlog"]
  manage_admin_password            = null
  namespace_name                   = "mdawarehouse"
  tags                             = {}
  tags_all                         = {}
}
