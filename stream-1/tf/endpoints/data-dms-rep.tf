
data "external" "repinstid" {
  program = ["bash", "get-rep-inst.sh"]
}

data "aws_dms_replication_instance" "aurora-s3-repinstance" {
  replication_instance_id = data.external.repinstid.result.Name
}