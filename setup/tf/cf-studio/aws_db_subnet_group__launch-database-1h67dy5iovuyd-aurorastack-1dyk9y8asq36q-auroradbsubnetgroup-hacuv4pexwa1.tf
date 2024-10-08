##START,aws_db_subnet_group
resource "aws_db_subnet_group" "launch-database-1h67dy5iovuyd-aurorastack-1dyk9y8asq36q-auroradbsubnetgroup-hacuv4pexwa1" {
  description = "Subnets available for the Aurora DB Instance"
  name        = "launch-database-1h67dy5iovuyd-aurorastack-1dyk9y8asq36q-auroradbsubnetgroup-hacuv4pexwa1"
  name_prefix = null
  subnet_ids  = [aws_subnet.subnet-02fb3e24f83650b37.id, aws_subnet.subnet-0a18186bf0066af18.id]
  tags        = {}
  tags_all    = {}
}
