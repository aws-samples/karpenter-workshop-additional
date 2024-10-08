##START,aws_eip
resource "aws_eip" "eipalloc-0dc3c94a8babe6ba6" {
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
