resource "aws_lakeformation_permissions" "tables_raw" {
  principal                     = data.aws_iam_role.GlueExecutionRole.arn
  permissions                   = ["ALTER", "SELECT"]


table {
    database_name = "raw"
    wildcard      = true
  }
}