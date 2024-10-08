##START,aws_security_group
resource "aws_security_group" "sg-0ab59ba3904ee2220" {
  description            = "Security group for Redshift cluster"
  name                   = "Redshift Security Group"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.vpc-0e4eecd9b51408770.id
}
