##START,aws_security_group_rule
resource "aws_security_group_rule" "sg-0160416f3f6d8b110_egress_all_0_0_0_0_0_0_0" {
  cidr_blocks              = ["0.0.0.0/0"]
  description              = null
  from_port                = 0
  prefix_list_ids          = []
  protocol                 = jsonencode(-1)
  security_group_id        = aws_security_group.sg-0160416f3f6d8b110.id
  source_security_group_id = null
  to_port                  = 0
  type                     = "egress"
}
