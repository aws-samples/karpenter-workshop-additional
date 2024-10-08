##START,aws_opensearch_domain
resource "aws_opensearch_domain" "aws-mda-aos-cluster" {
  access_policies = jsonencode({
    Statement = [{
      Action = "es:*"
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = format("arn:aws:es:%s:%s:domain/aws-mda-aos-cluster/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
    }]
    Version = "2012-10-17"
  })
  advanced_options = {
    override_main_response_version = "true"
  }
  domain_name     = "aws-mda-aos-cluster"
  engine_version  = "OpenSearch_2.11"
  ip_address_type = "ipv4"
  tags            = {}
  tags_all        = {}
  advanced_security_options {
    anonymous_auth_enabled         = false
    enabled                        = true
    internal_user_database_enabled = true
  }
  auto_tune_options {
    desired_state       = "ENABLED"
    rollback_on_disable = "NO_ROLLBACK"
    use_off_peak_window = false
  }
  cluster_config {
    dedicated_master_count        = 3
    dedicated_master_enabled      = true
    dedicated_master_type         = "r6g.large.search"
    instance_count                = 2
    instance_type                 = "r6g.large.search"
    multi_az_with_standby_enabled = false
    warm_enabled                  = false
    warm_type                     = null
    zone_awareness_enabled        = true
    cold_storage_options {
      enabled = false
    }
    zone_awareness_config {
      availability_zone_count = 2
    }
  }
  cognito_options {
    enabled          = false
    identity_pool_id = ""
    role_arn         = ""
    user_pool_id     = ""
  }
  domain_endpoint_options {
    custom_endpoint                 = null
    custom_endpoint_certificate_arn = null
    custom_endpoint_enabled         = false
    enforce_https                   = true
    tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
  }
  ebs_options {
    ebs_enabled = true
    iops        = 0
    volume_size = 20
    volume_type = "gp2"
  }
  encrypt_at_rest {
    enabled = true
  }
  node_to_node_encryption {
    enabled = true
  }
  off_peak_window_options {
    enabled = true
    off_peak_window {
      window_start_time {
        hours   = 21
        minutes = 0
      }
    }
  }
  snapshot_options {
    automated_snapshot_start_hour = 0
  }
  software_update_options {
    auto_software_update_enabled = false
  }
}
