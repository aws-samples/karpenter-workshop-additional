##START,aws_kms_key
resource "aws_kms_key" "k-52084661-d2d7-43ae-a54f-ebefc1c4c61a" {
  bypass_policy_lockout_safety_check = null
  custom_key_store_id                = null
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  deletion_window_in_days            = null
  description                        = null
  enable_key_rotation                = false
  is_enabled                         = true
  key_usage                          = "ENCRYPT_DECRYPT"
  multi_region                       = false
  policy = jsonencode({
    Id = "Key policy created by CloudTrail"
    Statement = [{
      Action = "kms:*"
      Effect = "Allow"
      Principal = {
        AWS = ["arn:aws:sts::007532665219:assumed-role/WSParticipantRole/Participant", "arn:aws:iam::007532665219:root"]
      }
      Resource = "*"
      Sid      = "Enable IAM User Permissions"
      }, {
      Action = "kms:GenerateDataKey*"
      Condition = {
        StringEquals = {
          "aws:SourceArn" = format("arn:aws:cloudtrail:%s:%s:trail/mda-events", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        }
        StringLike = {
          "kms:EncryptionContext:aws:cloudtrail:arn" = format("arn:aws:cloudtrail:*:%s:trail/*", data.aws_caller_identity.current.account_id)
        }
      }
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Resource = "*"
      Sid      = "Allow CloudTrail to encrypt logs"
      }, {
      Action = "kms:DescribeKey"
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Resource = "*"
      Sid      = "Allow CloudTrail to describe key"
      }, {
      Action = ["kms:Decrypt", "kms:ReEncryptFrom"]
      Condition = {
        StringEquals = {
          "kms:CallerAccount" = format("%s", data.aws_caller_identity.current.account_id)
        }
        StringLike = {
          "kms:EncryptionContext:aws:cloudtrail:arn" = format("arn:aws:cloudtrail:*:%s:trail/*", data.aws_caller_identity.current.account_id)
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "*"
      Sid      = "Allow principals in the account to decrypt log files"
      }, {
      Action = "kms:CreateAlias"
      Condition = {
        StringEquals = {
          "kms:CallerAccount" = format("%s", data.aws_caller_identity.current.account_id)
          "kms:ViaService"    = "ec2.eu-west-1.amazonaws.com"
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "*"
      Sid      = "Allow alias creation during setup"
      }, {
      Action = ["kms:Decrypt", "kms:ReEncryptFrom"]
      Condition = {
        StringEquals = {
          "kms:CallerAccount" = format("%s", data.aws_caller_identity.current.account_id)
        }
        StringLike = {
          "kms:EncryptionContext:aws:cloudtrail:arn" = format("arn:aws:cloudtrail:*:%s:trail/*", data.aws_caller_identity.current.account_id)
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "*"
      Sid      = "Enable cross account log decryption"
    }]
    Version = "2012-10-17"
  })
  tags       = {}
  tags_all   = {}
  xks_key_id = null
}
