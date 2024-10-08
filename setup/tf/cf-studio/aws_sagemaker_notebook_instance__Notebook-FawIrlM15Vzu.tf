##START,aws_sagemaker_notebook_instance
resource "aws_sagemaker_notebook_instance" "Notebook-FawIrlM15Vzu" {
  accelerator_types            = []
  additional_code_repositories = []
  default_code_repository      = null
  direct_internet_access       = "Enabled"
  instance_type                = "ml.t3.medium"
  lifecycle_config_name        = null
  name                         = "Notebook-FawIrlM15Vzu"
  platform_identifier          = "notebook-al2-v2"
  role_arn                     = format("arn:aws:iam::%s:role/SMNBIAMRole", data.aws_caller_identity.current.account_id)
  root_access                  = "Disabled"
  subnet_id                    = null
  tags                         = {}
  tags_all                     = {}
  volume_size                  = 20
  instance_metadata_service_configuration {
    minimum_instance_metadata_service_version = jsonencode(2)
  }
}
