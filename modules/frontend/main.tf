
resource "aws_s3_bucket" "odonto_soft" {
  bucket = "odonto_soft-${var.stage}"
  acl = "private"
  versioning {
    enabled = false
  }
}

