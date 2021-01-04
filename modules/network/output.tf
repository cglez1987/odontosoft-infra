output "vpc_id" {
  description = "Identifier of my VPC"
  value       = aws_vpc.main.id
  sensitive = false
}

output "vpc_arn" {
  description = "Arn of my VPC"
  value       = aws_vpc.main.arn
}

output "subnets_id" {
  description = "Ids of subnets"
  value       = aws_subnet.subnet[*].id
}

output "ava_zones" {
  value = data.aws_availability_zones.available.names[*]
}

output "elb_sg_id" {
  description = "Identifier of security group for ELB"
  value = aws_security_group.elb_sg.id
}

output "ec2_sg_id" {
  description = "Identifier of security group for EC2"
  value = aws_security_group.ec2_sg.id
}
