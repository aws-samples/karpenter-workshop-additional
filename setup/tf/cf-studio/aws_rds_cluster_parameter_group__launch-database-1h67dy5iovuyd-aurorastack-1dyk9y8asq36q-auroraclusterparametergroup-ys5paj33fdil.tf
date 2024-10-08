##START,aws_rds_cluster_parameter_group
resource "aws_rds_cluster_parameter_group" "launch-database-1h67dy5iovuyd-aurorastack-1dyk9y8asq36q-auroraclusterparametergroup-ys5paj33fdil" {
  description = "Enables CDC"
  family      = "aurora-postgresql13"
  name        = "launch-database-1h67dy5iovuyd-aurorastack-1dyk9y8asq36q-auroraclusterparametergroup-ys5paj33fdil"
  name_prefix = null
  tags        = {}
  tags_all    = {}
  parameter {
    apply_method = "immediate"
    name         = "wal_sender_timeout"
    value        = jsonencode(0)
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "rds.logical_replication"
    value        = jsonencode(1)
  }
}
