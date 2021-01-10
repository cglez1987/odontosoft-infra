output "app_url" {
  value = module.app_frontend.cloudfront_domain_name
}

output "app_backend_elb_url" {
  value = module.app_backend.elb_url
}

output "app_backend_asg_id" {
  value = module.app_backend.app_asg_id
}