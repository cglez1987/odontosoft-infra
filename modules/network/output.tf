output "vpc_id" {
  description = "Identifier of my VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "Arn of my VPC"
  value       = aws_vpc.main.arn
}

output "subnet1_id" {
  description = "Identifier of subnet1"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "Identifier of subnet2"
  value       = aws_subnet.subnet2.id
}

output "elb_sg_id" {
  description = "Identifier of security group for ELB"
  value = aws_security_group.elb_sg.id
}
