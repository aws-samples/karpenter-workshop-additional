##START,aws_eip
resource "aws_eip" "eipalloc-02f690f7de48547e1" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  domain                    = "vpc"
  instance                  = null
  network_border_group      = format("%s", data.aws_region.current.name)
  public_ipv4_pool          = "amazon"
  tags                      = {}
  tags_all                  = {}
}
