##START,aws_route_table_association
resource "aws_route_table_association" "subnet-02fb3e24f83650b37_rtb-0ed152ac64dcd476f" {
  route_table_id = aws_route_table.rtb-0ed152ac64dcd476f.id
  subnet_id      = aws_subnet.subnet-02fb3e24f83650b37.id
}
