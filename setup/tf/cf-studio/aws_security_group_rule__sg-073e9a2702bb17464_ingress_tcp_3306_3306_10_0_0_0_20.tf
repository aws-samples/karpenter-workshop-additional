##START,aws_security_group_rule
resource "aws_security_group_rule" "sg-073e9a2702bb17464_ingress_tcp_3306_3306_10_0_0_0_20" {
  cidr_blocks              = ["10.0.0.0/20"]
  description              = null
  from_port                = 3306
  prefix_list_ids          = []
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg-073e9a2702bb17464.id
  source_security_group_id = null
  to_port                  = 3306
  type                     = "ingress"
}
