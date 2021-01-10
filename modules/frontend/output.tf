output "s3_bucket_name" {
  description = "Bucket's name"
  value       = aws_s3_bucket.app_frontend_bucket.bucket
}


output "cloudfront_domain_name" {
  description = "Url to access Cloudfront distribution"
  value = module.cloudfront.this_cloudfront_distribution_domain_name
}