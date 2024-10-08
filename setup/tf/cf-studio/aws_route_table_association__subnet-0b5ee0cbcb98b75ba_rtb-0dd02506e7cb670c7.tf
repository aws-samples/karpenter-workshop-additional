##START,aws_route_table_association
resource "aws_route_table_association" "subnet-0b5ee0cbcb98b75ba_rtb-0dd02506e7cb670c7" {
  route_table_id = aws_route_table.rtb-0dd02506e7cb670c7.id
  subnet_id      = aws_subnet.subnet-0b5ee0cbcb98b75ba.id
}
