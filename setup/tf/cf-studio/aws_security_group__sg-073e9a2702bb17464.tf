##START,aws_security_group
resource "aws_security_group" "sg-073e9a2702bb17464" {
  description            = "Security group for Aurora DB Instance"
  name                   = "Aurora Security Group"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.vpc-0e4eecd9b51408770.id
}
