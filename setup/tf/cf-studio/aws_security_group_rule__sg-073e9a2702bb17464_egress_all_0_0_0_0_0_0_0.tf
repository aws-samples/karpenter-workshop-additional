##START,aws_security_group_rule
resource "aws_security_group_rule" "sg-073e9a2702bb17464_egress_all_0_0_0_0_0_0_0" {
  cidr_blocks              = ["0.0.0.0/0"]
  description              = null
  from_port                = 0
  prefix_list_ids          = []
  protocol                 = jsonencode(-1)
  security_group_id        = aws_security_group.sg-073e9a2702bb17464.id
  source_security_group_id = null
  to_port                  = 0
  type                     = "egress"
}
