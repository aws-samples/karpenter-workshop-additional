##START,aws_iam_role
resource "aws_iam_role" "QSNetworkRole" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "quicksight.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "QSNetworkRole"
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "NetworkEndpointPolicy"
    policy = jsonencode({
      Statement = [{
        Action   = ["ec2:CreateNetworkInterface", "ec2:ModifyNetworkInterfaceAttribute", "ec2:DeleteNetworkInterface", "ec2:DescribeSubnets", "ec2:DescribeSecurityGroups"]
        Effect   = "Allow"
        Resource = "*"
      }]
      Version = "2012-10-17"
    })
  }
}
