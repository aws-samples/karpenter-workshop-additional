##START,aws_route_table_association
resource "aws_route_table_association" "subnet-09e518797e71d41ee_rtb-0093705ecc776d260" {
  route_table_id = aws_route_table.rtb-0093705ecc776d260.id
  subnet_id      = aws_subnet.subnet-09e518797e71d41ee.id
}
