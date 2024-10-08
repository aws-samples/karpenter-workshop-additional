##START,aws_rds_cluster_instance
resource "aws_rds_cluster_instance" "mdadb" {
  apply_immediately               = null
  auto_minor_version_upgrade      = true
  availability_zone               = format("%sb", data.aws_region.current.name)
  ca_cert_identifier              = "rds-ca-rsa2048-g1"
  cluster_identifier              = aws_rds_cluster.launch-database-1h67dy5iovuyd-aurora-auroracluster-o3vjahxjyyzm.id
  copy_tags_to_snapshot           = false
  custom_iam_instance_profile     = null
  db_parameter_group_name         = "default.aurora-postgresql13"
  db_subnet_group_name            = aws_db_subnet_group.launch-database-1h67dy5iovuyd-aurorastack-1dyk9y8asq36q-auroradbsubnetgroup-hacuv4pexwa1.id
  engine                          = "aurora-postgresql"
  engine_version                  = jsonencode(13.9)
  identifier                      = "mdadb"
  identifier_prefix               = null
  instance_class                  = "db.t4g.medium"
  monitoring_interval             = 0
  monitoring_role_arn             = null
  performance_insights_enabled    = false
  performance_insights_kms_key_id = null
  preferred_backup_window         = "04:45-05:15"
  preferred_maintenance_window    = "fri:22:27-fri:22:57"
  promotion_tier                  = 1
  publicly_accessible             = false
  tags = {
    Application = "Aurora DB"
  }
  tags_all = {
    Application = "Aurora DB"
  }
}
