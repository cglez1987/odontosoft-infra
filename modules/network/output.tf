output "vpc_id" {
  description = "ID of my VPC"
  value       = module.vpc.vpc_id
  sensitive   = false
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "http_security_group" {
  value = module.http_80_security_group.this_security_group_id
}
