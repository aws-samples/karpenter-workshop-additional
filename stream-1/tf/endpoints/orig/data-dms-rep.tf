

variable "epinstid" {
  type = string
}


data "aws_dms_replication_instance" "aurora-s3-repinstance" {
  replication_instance_id = var.repinstid
}