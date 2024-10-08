##START,aws_redshift_subnet_group
resource "aws_redshift_subnet_group" "clustersubnetgroup-j7tqkmu1ewrb" {
  description = "Redshift Cluster Subnet Group"
  name        = "clustersubnetgroup-j7tqkmu1ewrb"
  subnet_ids  = [aws_subnet.subnet-02fb3e24f83650b37.id, aws_subnet.subnet-0a18186bf0066af18.id]
  tags        = {}
  tags_all    = {}
}
