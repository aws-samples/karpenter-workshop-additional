##START,aws_dms_replication_instance
resource "aws_dms_replication_instance" "aurora-s3-repinstance" {
  allocated_storage            = 100
  allow_major_version_upgrade  = null
  apply_immediately            = null
  auto_minor_version_upgrade   = true
  availability_zone            = format("%sa", data.aws_region.current.name)
  engine_version               = "3.5.2"
  kms_key_arn                  = "arn:aws:kms:eu-west-1:xxxxxxxxxxxx:key/cf77f16e-38b4-44f5-ad12-088cdefa84d6"
  multi_az                     = false
  network_type                 = "IPV4"
  preferred_maintenance_window = "tue:07:55-tue:08:25"
  publicly_accessible          = false
  replication_instance_class   = "dms.c5.xlarge"
  replication_instance_id      = "aurora-s3-repinstance"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dmsreplicationsubnetgroup-3xwpoxkvjyo3dczm.id
  tags                         = {}
  tags_all                     = {}
  vpc_security_group_ids       = [aws_security_group.sg-0160416f3f6d8b110.id]
}
