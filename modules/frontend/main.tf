
resource "aws_s3_bucket" "app_frontend_bucket" {
  bucket = "${var.app_name}-${var.stage}"
  acl    = var.bucket_acl
  versioning {
    enabled = var.bucket_versioning
  }
  force_destroy = true
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.app_frontend_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.this_cloudfront_origin_access_identity_iam_arns
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.app_frontend_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"
  version = "1.4.0"
  # aliases = ["${local.subdomain}.${local.domain_name}"]

  comment             = "Frontend Cloudfront for ${var.app_name} app"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }
  origin = {
    s3_one = {
      domain_name = aws_s3_bucket.app_frontend_bucket.bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one" # key in `origin_access_identities`
        # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
      }
    }
  }

  cache_behavior = {
    default = {
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "allow-all"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = false
      query_string    = true
    }
  }

  # geo_restriction = {
  #   restriction_type = "whitelist"
  #   locations        = ["NO", "UA", "US", "GB"]
  # }

}

