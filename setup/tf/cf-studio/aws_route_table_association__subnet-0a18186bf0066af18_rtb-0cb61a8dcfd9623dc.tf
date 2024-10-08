##START,aws_route_table_association
resource "aws_route_table_association" "subnet-0a18186bf0066af18_rtb-0cb61a8dcfd9623dc" {
  route_table_id = aws_route_table.rtb-0cb61a8dcfd9623dc.id
  subnet_id      = aws_subnet.subnet-0a18186bf0066af18.id
}
