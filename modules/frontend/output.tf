output "s3_bucket_name" {
  description = "Bucket's name"
  value       = aws_s3_bucket.odonto-soft.bucket
}
