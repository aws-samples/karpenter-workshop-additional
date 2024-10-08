##START,aws_kms_alias
resource "aws_kms_alias" "k-2d0349ec-c2ea-44b4-8839-105cd1994e02" {
  name          = "alias/mda-key-alias"
  name_prefix   = null
  target_key_id = aws_kms_key.k-2d0349ec-c2ea-44b4-8839-105cd1994e02.id
}
