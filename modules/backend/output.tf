output "app_url" {
  description = "Url to access the application via the Elastic Load Balancer"
  value       = "http://${aws_lb.app_elb.dns_name}:${var.elb_port}"
}
