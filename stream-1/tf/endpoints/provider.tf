terraform {
  required_version = "> 1.7.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
}
