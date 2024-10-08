##START,aws_nat_gateway
resource "aws_nat_gateway" "nat-047498946c479c4bf" {
  allocation_id                  = aws_eip.eipalloc-0dc3c94a8babe6ba6.id
  connectivity_type              = "public"
  secondary_allocation_ids       = []
  secondary_private_ip_addresses = []
  subnet_id                      = aws_subnet.subnet-0215abc2e240d5a8b.id
  tags                           = {}
  tags_all                       = {}
}
