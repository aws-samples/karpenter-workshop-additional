##START,aws_glue_catalog_table
resource "aws_glue_catalog_table" "d-007532665219__default__cloudtrail_logs_aws_cloudtrail_logs_007532665219_5cf285c3" {
  catalog_id    = format("%s", data.aws_caller_identity.current.account_id)
  database_name = aws_glue_catalog_database.d-007532665219__default.name
  description   = null
  name          = "cloudtrail_logs_aws_cloudtrail_logs_007532665219_5cf285c3"
  owner         = "hadoop"
  parameters = {
    EXTERNAL              = "TRUE"
    classification        = "cloudtrail"
    comment               = "CloudTrail table for aws-cloudtrail-logs-007532665219-5cf285c3 bucket"
    transient_lastDdlTime = "1725439136"
  }
  retention          = 0
  table_type         = "EXTERNAL_TABLE"
  view_expanded_text = null
  view_original_text = null
  storage_descriptor {
    additional_locations      = []
    bucket_columns            = []
    compressed                = false
    input_format              = "com.amazon.emr.cloudtrail.CloudTrailInputFormat"
    location                  = "s3://aws-cloudtrail-logs-007532665219-5cf285c3/AWSLogs/007532665219/CloudTrail"
    number_of_buckets         = -1
    output_format             = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    parameters                = {}
    stored_as_sub_directories = false
    columns {
      comment    = null
      name       = "eventversion"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "useridentity"
      parameters = {}
      type       = "struct<type:string,principalId:string,arn:string,accountId:string,invokedBy:string,accessKeyId:string,userName:string,sessionContext:struct<attributes:struct<mfaAuthenticated:string,creationDate:string>,sessionIssuer:struct<type:string,principalId:string,arn:string,accountId:string,username:string>,ec2RoleDelivery:string,webIdFederationData:map<string,string>>>"
    }
    columns {
      comment    = null
      name       = "eventtime"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "eventsource"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "eventname"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "awsregion"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "sourceipaddress"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "useragent"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "errorcode"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "errormessage"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "requestparameters"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "responseelements"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "additionaleventdata"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "requestid"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "eventid"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "resources"
      parameters = {}
      type       = "array<struct<arn:string,accountId:string,type:string>>"
    }
    columns {
      comment    = null
      name       = "eventtype"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "apiversion"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "readonly"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "recipientaccountid"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "serviceeventdetails"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "sharedeventid"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "vpcendpointid"
      parameters = {}
      type       = "string"
    }
    columns {
      comment    = null
      name       = "tlsdetails"
      parameters = {}
      type       = "struct<tlsVersion:string,cipherSuite:string,clientProvidedHostHeader:string>"
    }
    ser_de_info {
      name = null
      parameters = {
        "serialization.format" = "1"
      }
      serialization_library = "org.apache.hive.hcatalog.data.JsonSerDe"
    }
    skewed_info {
      skewed_column_names               = []
      skewed_column_value_location_maps = {}
      skewed_column_values              = []
    }
  }
}
