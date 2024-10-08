##START,aws_subnet
resource "aws_subnet" "subnet-0215abc2e240d5a8b" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = format("%sa", data.aws_region.current.name)
  cidr_block                                     = "10.0.3.0/24"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  tags_all = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  vpc_id = aws_vpc.vpc-0e4eecd9b51408770.id
}
