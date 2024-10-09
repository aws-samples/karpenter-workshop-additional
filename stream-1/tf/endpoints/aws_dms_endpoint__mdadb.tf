##START,aws_dms_endpoint

variable "pw1" {
  type = string
  default = "Admin123$"
}

resource "aws_dms_endpoint" "mdadb" {
  certificate_arn = null
  database_name   = "mdacluster"
  endpoint_id     = "mdadb"

  lifecycle {
    ignore_changes = [s3_settings, postgres_settings[0].max_file_size]
  }
  endpoint_type                   = "source"
  engine_name                     = "aurora-postgresql"
  extra_connection_attributes     = null
  kms_key_arn                     = data.aws_kms_key.dms.arn
  password                        = var.pw1
  pause_replication_tasks         = null
  port                            = 3306
  secrets_manager_access_role_arn = null
  secrets_manager_arn             = null
  server_name                     = "mdadb.chk4g8maydyw.eu-west-1.rds.amazonaws.com"
  service_access_role             = null
  ssl_mode                        = "none"
  tags                            = {}
  tags_all                        = {}
  username                        = "mdauser"
  postgres_settings {
    after_connect_script         = null
    babelfish_database_name      = null
    capture_ddls                 = false
    database_mode                = null
    ddl_artifacts_schema         = null
    execute_timeout              = 0
    fail_tasks_on_lob_truncation = false
    heartbeat_enable             = false
    heartbeat_frequency          = 0
    heartbeat_schema             = null
    map_boolean_as_boolean       = false
    map_jsonb_as_clob            = false
    map_long_varchar_as          = null
    max_file_size                = 1048576
    plugin_name                  = null
    slot_name                    = null
  }
}
