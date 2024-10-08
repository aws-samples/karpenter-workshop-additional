##START,aws_redshiftserverless_workgroup
resource "aws_redshiftserverless_workgroup" "mdawarehouse-workgroup" {
  base_capacity        = 128
  enhanced_vpc_routing = false
  max_capacity         = 0
  namespace_name       = aws_redshiftserverless_namespace.mdawarehouse.id
  port                 = 5439
  publicly_accessible  = false
  security_group_ids   = [aws_security_group.sg-0ab59ba3904ee2220.id]
  subnet_ids           = [aws_subnet.subnet-02fb3e24f83650b37.id, aws_subnet.subnet-09e518797e71d41ee.id, aws_subnet.subnet-0a18186bf0066af18.id]
  tags                 = {}
  tags_all             = {}
  workgroup_name       = "mdawarehouse-workgroup"
  config_parameter {
    parameter_key   = "auto_mv"
    parameter_value = jsonencode(true)
  }
  config_parameter {
    parameter_key   = "datestyle"
    parameter_value = "ISO, MDY"
  }
  config_parameter {
    parameter_key   = "enable_case_sensitive_identifier"
    parameter_value = jsonencode(false)
  }
  config_parameter {
    parameter_key   = "enable_user_activity_logging"
    parameter_value = jsonencode(true)
  }
  config_parameter {
    parameter_key   = "max_query_execution_time"
    parameter_value = jsonencode(14400)
  }
  config_parameter {
    parameter_key   = "query_group"
    parameter_value = "default"
  }
  config_parameter {
    parameter_key   = "require_ssl"
    parameter_value = jsonencode(false)
  }
  config_parameter {
    parameter_key   = "search_path"
    parameter_value = "$user, public"
  }
  config_parameter {
    parameter_key   = "use_fips_ssl"
    parameter_value = jsonencode(false)
  }
}
