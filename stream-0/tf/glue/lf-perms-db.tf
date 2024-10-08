resource "aws_lakeformation_permissions" "raw" {
  principal   = data.aws_iam_role.GlueExecutionRole.arn
  permissions = ["CREATE_TABLE"]

  database {
    name       = "raw"
    catalog_id = data.aws_caller_identity.current.account_id
  }
}

resource "aws_lakeformation_permissions" "analytics" {
  principal   = data.aws_iam_role.GlueExecutionRole.arn
  permissions = ["CREATE_TABLE"]

  database {
    name       = "analytics"
    catalog_id = data.aws_caller_identity.current.account_id
  }
}


resource "aws_lakeformation_permissions" "stage" {
  principal   = data.aws_iam_role.GlueExecutionRole.arn
  permissions = ["CREATE_TABLE"]

  database {
    name       = "stage"
    catalog_id = data.aws_caller_identity.current.account_id
  }
}