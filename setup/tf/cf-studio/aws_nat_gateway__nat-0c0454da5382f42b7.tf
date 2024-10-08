##START,aws_nat_gateway
resource "aws_nat_gateway" "nat-0c0454da5382f42b7" {
  allocation_id                  = aws_eip.eipalloc-02f690f7de48547e1.id
  connectivity_type              = "public"
  secondary_allocation_ids       = []
  secondary_private_ip_addresses = []
  subnet_id                      = aws_subnet.subnet-0b5ee0cbcb98b75ba.id
  tags                           = {}
  tags_all                       = {}
}
