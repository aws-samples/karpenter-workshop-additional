##START,aws_kms_alias
resource "aws_kms_alias" "k-52084661-d2d7-43ae-a54f-ebefc1c4c61a" {
  name          = "alias/mda-key-alias"
  name_prefix   = null
  target_key_id = aws_kms_key.k-52084661-d2d7-43ae-a54f-ebefc1c4c61a.id
}
