##START,aws_vpc
resource "aws_vpc" "vpc-0e4eecd9b51408770" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.0.0.0/20"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  ipv4_ipam_pool_id                    = null
  ipv4_netmask_length                  = null
  ipv6_cidr_block                      = null
  ipv6_cidr_block_network_border_group = null
  ipv6_ipam_pool_id                    = null
  tags = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
    Name        = "DatabaseVPC"
  }
  tags_all = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
    Name        = "DatabaseVPC"
  }
}
