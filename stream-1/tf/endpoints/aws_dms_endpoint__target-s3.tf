##START,aws_dms_endpoint
resource "aws_dms_endpoint" "target-s3" {
  certificate_arn = null
  database_name   = null
  endpoint_id     = "target-s3"

  lifecycle {
    ignore_changes = [s3_settings, postgres_settings[0].max_file_size]
  }
  endpoint_type                   = "target"
  engine_name                     = "s3"
  extra_connection_attributes     = "addColumnName=true;bucketFolder=reviews;bucketName=007532665219-eu-west-1-datalake-raw;compressionType=NONE;csvDelimiter=,;csvRowDelimiter=\\n;datePartitionEnabled=false;"
  password                        = null # sensitive
  pause_replication_tasks         = null
  port                            = null
  secrets_manager_access_role_arn = null
  secrets_manager_arn             = null
  server_name                     = null
  service_access_role             = null
  ssl_mode                        = "none"
  tags                            = {}
  tags_all                        = {}
  username                        = null
  s3_settings {
    add_column_name                             = false
    bucket_folder                               = "reviews"
    bucket_name                                 = format("%s-%s-datalake-raw",data.aws_caller_identity.current.account_id,data.aws_region.current.name)
    canned_acl_for_objects                      = null
    cdc_inserts_and_updates                     = false
    cdc_inserts_only                            = false
    cdc_max_batch_interval                      = 0
    cdc_min_file_size                           = 0
    cdc_path                                    = null
    compression_type                            = "NONE"
    csv_delimiter                               = ","
    csv_no_sup_value                            = null
    csv_null_value                              = null
    csv_row_delimiter                           = "\\n"
    data_format                                 = null
    data_page_size                              = 0
    date_partition_delimiter                    = null
    date_partition_enabled                      = false
    date_partition_sequence                     = null
    dict_page_size_limit                        = 0
    enable_statistics                           = true
    encoding_type                               = null
    encryption_mode                             = null
    external_table_definition                   = null
    glue_catalog_generation                     = false
    ignore_header_rows                          = 0
    include_op_for_full_load                    = false
    max_file_size                               = 1048576
    parquet_timestamp_in_millisecond            = false
    parquet_version                             = null
    preserve_transactions                       = false
    rfc_4180                                    = false
    row_group_length                            = 0
    server_side_encryption_kms_key_id           = null
    service_access_role_arn                     = format("arn:aws:iam::%s:role/DMSExecutionRole", data.aws_caller_identity.current.account_id)
    timestamp_column_name                       = null
    use_csv_no_sup_value                        = false
    use_task_start_time_for_full_load_timestamp = false
  }
}
