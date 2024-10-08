##START,aws_internet_gateway
resource "aws_internet_gateway" "igw-015e3b233705bd803" {
  tags = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  tags_all = {
    Application = format("arn:aws:cloudformation:%s:%s:stack/launch-Database-1H67DY5IOVUYD-VPCStack-15EUWESI8KQ8H/15147920-655a-11ef-bedf-0a0759182949", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  }
  vpc_id = aws_vpc.vpc-0e4eecd9b51408770.id
}
