
resource "aws_s3_bucket" "odonto-soft" {
  bucket = "odontosoft-${var.stage}"
  acl = "private"
  versioning {
    enabled = false
  }
}

