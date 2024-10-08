data "aws_iam_role" "GlueExecutionRole" {
    name = "GlueExecutionRole"
}

data "aws_iam_role" "WSParticipantRole" {
    name = "WSParticipantRole"
}