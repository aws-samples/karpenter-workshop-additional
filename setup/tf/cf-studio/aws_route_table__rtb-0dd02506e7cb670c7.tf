##START,aws_route_table
resource "aws_route_table" "rtb-0dd02506e7cb670c7" {
  propagating_vgws = []
  route = [{
    carrier_gateway_id         = ""
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    gateway_id                 = aws_internet_gateway.igw-015e3b233705bd803.id
    ipv6_cidr_block            = null
    local_gateway_id           = ""
    nat_gateway_id             = ""
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
  }]
  tags = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  tags_all = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  vpc_id = aws_vpc.vpc-0e4eecd9b51408770.id
}
