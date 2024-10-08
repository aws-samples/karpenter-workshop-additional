##START,aws_route_table_association
resource "aws_route_table_association" "subnet-095627119262f29a1_rtb-0dd02506e7cb670c7" {
  route_table_id = aws_route_table.rtb-0dd02506e7cb670c7.id
  subnet_id      = aws_subnet.subnet-095627119262f29a1.id
}
