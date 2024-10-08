##START,aws_redshift_cluster
resource "aws_redshift_cluster" "mdawarehouse-tsdvavsju6ac" {
  allow_version_upgrade = true
  apply_immediately     = false
  lifecycle {
    ignore_changes = [apply_immediately, cluster_version]
  }
  automated_snapshot_retention_period  = 1
  availability_zone                    = format("%sb", data.aws_region.current.name)
  availability_zone_relocation_enabled = false
  cluster_identifier                   = "mdawarehouse-tsdvavsju6ac"
  cluster_parameter_group_name         = "default.redshift-1.0"
  cluster_public_key                   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCT0/v9pUxo9qIXsUmyocuQC+1hdTCRZLDuMdHKCvKKfAr60BXtH4uLMQ+DeC9mkDN7lCNMCa63gYcUUuOYRkJWeOtUxiuUYegsTJbLc0zT9P2besTOS8NCUH84jkkqME7f4PQfBf0wiJEfwOs7qAghsAxM8LM+hLs3IPRfc8/wdUACc8pp8thOxfoHDO/KOwwg0E56aDZIKyz/+LPkTzTLvkU5rp0ZjOnj8bB6s0AnLshJ3CykqmpBwA48wVODmw8MuesRQObfvGNPWr0AltiYT3XKuJoICIsotbPNNG0AxE1yUSGPj1KJZ6bAl2zWi5fyp1Gt+QfGFFpOPBkdIEt7 Amazon-Redshift\n"
  cluster_revision_number              = jsonencode(73348)
  cluster_subnet_group_name            = aws_redshift_subnet_group.clustersubnetgroup-j7tqkmu1ewrb.id
  cluster_type                         = "multi-node"
  cluster_version                      = jsonencode(1)
  database_name                        = "dev"
  default_iam_role_arn                 = null
  elastic_ip                           = null
  encrypted                            = true
  enhanced_vpc_routing                 = false
  final_snapshot_identifier            = null
  iam_roles                            = [aws_iam_role.RedshiftExecutionRole.arn]
  maintenance_track_name               = "current"
  manage_master_password               = null
  manual_snapshot_retention_period     = -1
  master_password                      = null # sensitive
  master_password_secret_kms_key_id    = null
  master_username                      = "admin"
  multi_az                             = false
  node_type                            = "ra3.4xlarge"
  number_of_nodes                      = 2
  owner_account                        = null
  port                                 = 5439
  preferred_maintenance_window         = "sun:02:00-sun:02:30"
  publicly_accessible                  = false
  skip_final_snapshot                  = true
  snapshot_arn                         = null
  snapshot_cluster_identifier          = null
  snapshot_identifier                  = null
  tags                                 = {}
  tags_all                             = {}
  vpc_security_group_ids               = [aws_security_group.sg-0ab59ba3904ee2220.id]
}
