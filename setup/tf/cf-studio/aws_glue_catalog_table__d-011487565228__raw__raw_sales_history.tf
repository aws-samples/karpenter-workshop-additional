##START,aws_glue_catalog_table
resource "aws_glue_catalog_table" "d-011487565228__raw__raw_sales_history" {
  catalog_id    = format("%s", data.aws_caller_identity.current.account_id)
  database_name = aws_glue_catalog_database.d-011487565228__raw.name
  description   = "Sales history Data Table"
  name          = "raw_sales_history"
  owner         = null
  parameters = {
    areColumnsQuoted         = "false"
    classification           = "csv"
    columnsOrdered           = "true"
    compressionType          = "none"
    "skip.header.line.count" = "1"
    typeOfData               = "file"
  }
  retention          = 0
  table_type         = null
  view_expanded_text = null
  view_original_text = null
  storage_descriptor {
    additional_locations      = []
    bucket_columns            = []
    compressed                = false
    input_format              = "org.apache.hadoop.mapred.TextInputFormat"
    location                  = "s3://011487565228-eu-west-1-datalake-raw/sales_history/"
    number_of_buckets         = 0
    output_format             = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    parameters                = {}
    stored_as_sub_directories = false
    ser_de_info {
      name = null
      parameters = {
        "field.delim" = ","
      }
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
    }
  }
}
