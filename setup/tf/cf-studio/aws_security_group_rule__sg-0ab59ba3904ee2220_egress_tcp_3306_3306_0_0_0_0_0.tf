##START,aws_security_group_rule
resource "aws_security_group_rule" "sg-0ab59ba3904ee2220_egress_tcp_3306_3306_0_0_0_0_0" {
  cidr_blocks              = ["0.0.0.0/0"]
  description              = null
  from_port                = 3306
  prefix_list_ids          = []
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg-0ab59ba3904ee2220.id
  source_security_group_id = null
  to_port                  = 3306
  type                     = "egress"
}
