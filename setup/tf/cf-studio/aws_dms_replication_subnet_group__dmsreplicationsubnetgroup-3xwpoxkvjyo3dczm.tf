##START,aws_dms_replication_subnet_group
resource "aws_dms_replication_subnet_group" "dmsreplicationsubnetgroup-3xwpoxkvjyo3dczm" {
  replication_subnet_group_description = "Subnets available for DMS"
  replication_subnet_group_id          = "dmsreplicationsubnetgroup-3xwpoxkvjyo3dczm"
  subnet_ids                           = [aws_subnet.subnet-02fb3e24f83650b37.id, aws_subnet.subnet-0a18186bf0066af18.id]
  tags                                 = {}
  tags_all                             = {}
}
